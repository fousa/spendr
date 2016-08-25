//
//  TypeSelectionTableViewModel.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 25/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Foundation
import CloudKit

class TypeSelectionTableViewModel {
    
    // MARK: - Internals
    
    private let database = CKContainer.defaultContainer().publicCloudDatabase
    private lazy var query: CKQuery = {
        let predicate = NSPredicate(value: true)
        return CKQuery(recordType: "ExpenseType", predicate: predicate)
    }()
    
    // MARK: - CloudKit
    
    func reload() {
        database.performQuery(query, inZoneWithID: nil) { records, error in
            print(error)
            print(records)
        }
    }
    
}