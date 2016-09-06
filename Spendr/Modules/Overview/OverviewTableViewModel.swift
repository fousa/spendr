//
//  OverviewTableViewModel.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 01/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Foundation
import ReactiveKit
import CloudKit

class OverviewTableViewModel {

    // MARK: - Properties

    private(set) var expenses = CollectionProperty<[CKRecord]>([])

    // MARK: - Initialization

    init() {
        CloudHandler.shared.fetchExpenses(forMonth: NSDate()) { expenses in
            self.expenses.replace(expenses)
        }
    }
    
    // MARK: - Expense types
    
    func expenseType(forExpense expense: CKRecord) -> ExpenseType? {
        guard let expenseTypeReference = expense["type"] as? CKReference else {
            return nil
        }
        
        return DatabaseHandler.shared.expenseTypes.filter("recordName = '\(expenseTypeReference.recordID.recordName)'").first
    }

}