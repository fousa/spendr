//
//  TypeSelectionTableViewModel.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 25/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Foundation
import CloudKit
import ReactiveKit

class TypeSelectionTableViewModel {

    // MARK: - Properties

    private(set) var title = Property<String>("Selecteer een type")
    private(set) var expenseTypes = CollectionProperty<[ExpenseType]>([])

    // MARK: - Internals
    
    private let database = CKContainer.defaultContainer().publicCloudDatabase
    private lazy var query: CKQuery = {
        let predicate = NSPredicate(value: true)
        return CKQuery(recordType: "ExpenseType", predicate: predicate)
    }()

    // MARK: - Init

    init() {
        fetchExpenseTypes()
    }
    
    // MARK: - CloudKit
    
    private func fetchExpenseTypes() {
        database.performQuery(query, inZoneWithID: nil) { records, error in
            if let records = records {
                let expenseTypes = records.flatMap { record -> ExpenseType? in
                    return ExpenseType(record: record)
                }
                self.expenseTypes.replace(expenseTypes)
            }
        }
    }
    
}