//
//  BudgetTableViewModel.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 11/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Foundation
import ReactiveKit
import CloudKit

class BudgetTableViewModel {

    // MARK: - Properties

    private(set) var expenseTypes = CollectionProperty<[ExpenseType]>([])

    // MARK: - Initialization

    init() {
        self.expenseTypes.replace(Array(DatabaseHandler.shared.expenseTypes))

        CloudHandler.shared.fetchExpenses(forMonth: NSDate()) { expenses in
//            self.expenses.replace(expenses)
        }
    }

    // MARK: - Expense types

//    func expenseType(forExpense expense: CKRecord) -> ExpenseType? {
//        guard let expenseTypeReference = expense["type"] as? CKReference else {
//            return nil
//        }
//
//        return DatabaseHandler.shared.expenseTypes.filter("recordName = '\(expenseTypeReference.recordID.recordName)'").first
//    }

}