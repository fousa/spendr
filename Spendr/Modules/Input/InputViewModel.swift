//
//  InputViewModel.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 23/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Foundation
import CloudKit
import ReactiveKit

class InputViewModel: NSObject {

    // MARK: - Properties

    private(set) var amount = Property<Double>(0)
    private(set) var amountFormatted = Property<String>("0")
    private(set) var amountString = Property<String?>(nil)

    // MARK: - Internals

    private lazy var formatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter
    }()

    private let database = CKContainer.defaultContainer().privateCloudDatabase

    // MARK: - Init

    override init() {
        super.init()

        // Setup bindings
        amountString.observeNext { [weak self] amountString in
            guard let weakSelf = self else { return }

            weakSelf.amount.value = weakSelf.convert(rawAmount: amountString)
            weakSelf.amountFormatted.value = weakSelf.format(amount: weakSelf.amount.value)
        }.disposeIn(rBag)
    }

    // MARK: - Validation

    var valid: Bool {
        return amount.value > 0
    }

    // MARK: - Creation

    func save(expenseType expenseType: ExpenseType, completion: (error: NSError?) -> ()) {
        let expenseRecord = CKRecord(recordType: "Expense")
        expenseRecord["amount"] = amount.value
        expenseRecord["date"] = NSDate()
        expenseRecord["type"] = CKReference(recordID: expenseType.record.recordID, action: .None)
        database.saveRecord(expenseRecord) { record, error in
            completion(error: error)
        }
    }

    // MARK: - Converting

    private func convert(rawAmount rawAmount: String?) -> Double {
        guard let
            rawAmount = rawAmount,
            amount = Double(rawAmount) else {
            return 0.0
        }
        return amount / 100.0
    }

    private func format(amount amount: Double) -> String {
        return formatter.stringFromNumber(amount)!
    }

}