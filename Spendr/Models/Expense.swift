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

class Expense: Object {

    // MARK: - Properties

    private(set) dynamic var id = NSUUID().UUIDString
    dynamic var expenseType: ExpenseType? = nil
    dynamic var amount: Double = 0
    dynamic var createdAt: NSDate? = nil

    // MARK: - Init

    convenience init(expenseType: ExpenseType) {
        self.init()

        self.expenseType = expenseType
    }

    // MARK: - Cloud

    var record: CKRecord {
        let record = CKRecord(recordType: "Expense")
        record["amount"] = amount
        record["date"] = createdAt
        if let expenseType = expenseType {
            let recordID =  CKRecordID(recordName: expenseType.recordName)
            record["type"] = CKReference(recordID: recordID, action: .None)
        }
        return record
    }

}