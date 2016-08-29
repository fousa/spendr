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

        printBreadcrumb("💡Fetched", records.count)
        let expenseTypes = records.flatMap { record -> ExpenseType? in
            return try? ExpenseType(record: record)
        }

        printBreadcrumb("💡Parsed", expenseTypes.count)
        try saveOnMainThread(records: expenseTypes)
        printBreadcrumb("💡Saved", expenseTypes.count)

        return expenseTypes
    }

    // MARK: - Expense

    func save(expense expense: Expense) throws {
        try saveOnMainThread(records: [expense], update: false)
        printBreadcrumb("💰Saved", expense.expenseType!.name)
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