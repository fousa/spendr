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

    // MARK: - Properties

    static let shared = DatabaseHandler()

    // MARK: - Internals

    private lazy var realm: Realm = {
        return try! Realm()
    }()

    // MARK: - ExpenseType

    func save(expenseTypeRecords records: [CKRecord]?) throws -> [ExpenseType] {
        guard let records = records else {
            throw DatabaseHandlerError.noRecords
        }

        printBreadcrumb("Fetched", records.count, "expenseType records")
        let expenseTypes = records.flatMap { record -> ExpenseType? in
            return try? ExpenseType(record: record)
        }

        printBreadcrumb("Parsed", expenseTypes.count, "expenseType records")
        try saveOnMainThread(records: expenseTypes)

        return expenseTypes
    }

    // MARK: - Saving

    private func saveOnMainThread(records records: [Object]) throws {
        func save() {
            do {
                try realm.write {
                    realm.add(records, update: true)
                }
            } catch {}
        }

        dispatch_on_main(save)
    }

}