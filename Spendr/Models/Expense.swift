//
//  Expense.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 29/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import CloudKit
import Realm
import RealmSwift

//enum ExpenseTypeError: ErrorType {
//    case invalidJSON
//}

class Expense: Object {

    // MARK: - Properties

    dynamic var expenseType: ExpenseType? = nil
    dynamic var amount: Double = 0
    dynamic var createdAt: NSDate? = nil

    // MARK: - Init

    convenience init(expenseType: ExpenseType) {
        self.init()

        self.expenseType = expenseType
    }

}