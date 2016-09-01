//
//  CloudHandler.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 29/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import CloudKit
import ReactiveKit
import Stella
import RealmSwift

class CloudHandler {

    // MARK: - Properties

    private(set) var totalAmount = ReactiveKit.Property<Double>(0.0)

    // MARK: - Internals

    private var notificationToken: NotificationToken?
    private var uploading = [String]()

    // MARK: - Init

    static let shared = CloudHandler()

    init() {
        notificationToken = DatabaseHandler.shared.expenses.addNotificationBlock { results in
            let expenses = DatabaseHandler.shared.expenses
            printBreadcrumb("💰UI", expenses.count)
            for expense in expenses {
                self.save(expense: expense)
            }
        }
    }

    deinit {
        notificationToken?.stop()
    }

    // MARK: - Internals

    private let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
    private let privateDatabase = CKContainer.defaultContainer().privateCloudDatabase
    private lazy var query: CKQuery = {
        let predicate = NSPredicate(value: true)
        return CKQuery(recordType: "ExpenseType", predicate: predicate)
    }()

    // MARK: - Expense Types

    func fetchExpenseTypes() {
        publicDatabase.performQuery(query, inZoneWithID: nil) { records, error in
            do {
                let _ = try DatabaseHandler.shared.save(expenseTypeRecords: records)
            } catch {}
        }
    }

    // MARK: - Expense

    func fetchExpenses(forMonth date: NSDate) {
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        let components = calendar.components([.Era, .Year, .Month, .Day], fromDate: date)
        components.day = 1
        components.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        let startDate = calendar.dateFromComponents(components)!

        let monthComponents = NSDateComponents()
        monthComponents.month = 1
        let endDate = calendar.dateByAddingComponents(monthComponents, toDate: startDate, options: .MatchStrictly)!

        let predicate = NSPredicate(format: "date >= %@ AND date < %@", startDate, endDate)
        let query = CKQuery(recordType: "Expense", predicate: predicate)
        privateDatabase.performQuery(query, inZoneWithID: nil) { records, error in
            if let records = records {
                printBreadcrumb("💰Fetched expenses", records.count)
                dispatch_on_main({
                    self.totalAmount.value = records.reduce(0.0, combine: { total, expense -> Double in
                        return total + (expense["amount"] as! Double)
                    })
                    printBreadcrumb("💰Fetched total", self.totalAmount.value)
                })
            }
        }
    }

    private func save(expense expense: Expense) {
        if uploading.contains(expense.id) {
            printBreadcrumb("💰Already uploading", expense.id)
            return
        }

        uploading.append(expense.id)
        privateDatabase.saveRecord(expense.record) { record, error in
            dispatch_on_main {
                let id = expense.id
                try! DatabaseHandler.shared.delete(expense: expense)
                if let index = self.uploading.indexOf(id) {
                    self.uploading.removeAtIndex(index)
                }
                printBreadcrumb("💰Uploaded", id)
            }
        }
    }

}