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

    private(set) var expenseTypes = CollectionProperty<[String]>([])

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
                let names = records.flatMap({ (record) -> String? in
                    return record["name"] as! String?
                })
                self.expenseTypes.replace(names)
            }
        }
    }
    
}