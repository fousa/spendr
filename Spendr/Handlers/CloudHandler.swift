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

    private let database = CKContainer.defaultContainer().publicCloudDatabase
    private lazy var query: CKQuery = {
        let predicate = NSPredicate(value: true)
        return CKQuery(recordType: "ExpenseType", predicate: predicate)
    }()

    // MARK: - Expense Types

    func fetchExpenseTypes() {
        database.performQuery(query, inZoneWithID: nil) { records, error in
            do {
                let _ = try DatabaseHandler.shared.save(expenseTypeRecords: records)
            } catch {}
        }
    }

    // MARK: - Expense

    private func save(expense expense: Expense) {
        if uploading.contains(expense.id) {
            printBreadcrumb("💰 Already uploading", expense.id)
            return
        }

        uploading.append(expense.id)
        database.saveRecord(expense.record) { record, error in
            dispatch_on_main { 
                printBreadcrumb("💰 Uploaded", expense.id)
            }
        }
    }

}