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

    func save(expenseTypeRecords records: [CKRecord]?) throws {
        guard let records = records else {
            throw DatabaseHandlerError.noRecords
        }

        printBreadcrumb("Fetched", records.count, "expenseType records")
        let expenseTypes = records.flatMap { record -> ExpenseType? in
            return try? ExpenseType(record: record)
        }

        printBreadcrumb("Parsed", expenseTypes.count, "expenseType records")
        try realm.write {
            realm.add(expenseTypes, update: true)
        }
    }

}