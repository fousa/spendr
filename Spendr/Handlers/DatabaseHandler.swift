//
//  DatabaseHandler.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 29/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Realm
import RealmSwift
import CloudKit
import Stella

enum DatabaseHandlerError: ErrorType {
    case noRecords
}

class DatabaseHandler {

    // MARK: - Init

    static let shared = DatabaseHandler()

    // MARK: - Database

    private lazy var realm: Realm = {
        return try! Realm()
    }()

    // MARK: - ExpenseType

    lazy var expenseTypes: Results<ExpenseType> = {
        return self.realm.objects(ExpenseType.self)
    }()

    func save(expenseTypeRecords records: [CKRecord]?) throws -> [ExpenseType] {
        guard let records = records else {
            throw DatabaseHandlerError.noRecords
        }

        printBreadcrumb("💡Fetched expense types", records.count)
        let expenseTypes = records.flatMap { record -> ExpenseType? in
            return try? ExpenseType(record: record)
        }

        printBreadcrumb("💡Parsed expense types", expenseTypes.count)
        try saveOnMainThread(records: expenseTypes)
        printBreadcrumb("💡Saved expense types", expenseTypes.count)

        return expenseTypes
    }

    // MARK: - Expense

    lazy var expenses: Results<Expense> = {
        return self.realm.objects(Expense.self)
    }()

    func fetchExpenses(forMonth date: NSDate) -> Results<Expense> {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Era, .Year, .Month, .Day], fromDate: date)
        components.day = 1
        let startDate = calendar.dateFromComponents(components)!

        let monthComponents = NSDateComponents()
        monthComponents.month = 1
        let endDate = calendar.dateByAddingComponents(monthComponents, toDate: startDate, options: .MatchStrictly)!

        let predicate = NSPredicate(format: "createdAt >= %@ AND createdAt < %@", argumentArray: [startDate, endDate])
        return self.realm.objects(Expense.self).filter(predicate)
    }

    func save(expense expense: Expense) throws {
        try saveOnMainThread(records: [expense], update: false)
        printBreadcrumb("💰Saved", expense.expenseType!.name)
    }

    func delete(expense expense: Expense) throws {
        do {
            try realm.write {
                let id = expense.id
                realm.delete(expense)
                printBreadcrumb("💰Deleted", id)
            }
        } catch {}
    }

    // MARK: - Saving

    private func saveOnMainThread(records records: [Object], update: Bool = true) throws {
        func save() {
            do {
                try realm.write {
                    realm.add(records, update: update)
                }
            } catch {}
        }

        dispatch_on_main(save)
    }

}