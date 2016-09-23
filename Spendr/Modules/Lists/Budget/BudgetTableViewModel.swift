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
    private(set) var sortedExpenseTypes = CollectionProperty<[ExpenseType]>([])

    // MARK: - Initialization

    init() {
        expenseTypes.sort{ $0.amount > $1.amount }.bindTo(sortedExpenseTypes)
        expenseTypes.replace(Array(DatabaseHandler.shared.expenseTypes))

        CloudHandler.shared.fetchExpenses(forMonth: NSDate()) { expenses in
            self.updateBudget(forExpenses: expenses)

        }
    }

    // MARK: - Expenses

    private func updateBudget(forExpenses expenses: [CKRecord]) {
        for expense in expenses {
            if let
                expenseTypeReference = expense["type"] as? CKReference,
                index = expenseTypes.value.indexOf({ $0.recordName == expenseTypeReference.recordID.recordName }) {
                expenseTypes.value[index].amount += expense["amount"] as! Double
            }
        }
        self.expenseTypes.replace(self.expenseTypes.value)
    }

}