//
//  CloudHandler.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 29/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import CloudKit
import ReactiveKit

class CloudHandler {

    // MARK: - Init

    static let shared = CloudHandler()

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

}