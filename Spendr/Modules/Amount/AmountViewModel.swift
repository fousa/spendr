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
import Stella

class AmountViewModel: NSObject {

    // MARK: - Data

    private var amount: Double = 0

    // MARK: - Formatting

    var formattedAmount: String {
        return formatter.stringFromNumber(amount)!
    }

    var formattedExpenseType: String {
        return expenseType.value?.name ?? "???"
    }

    var formattedLabel: String {
        return "I\nspent\n\(formattedAmount)\non my \(formattedExpenseType)\nbudget"
    }

    // MARK: - Properties

    private(set) var expenseType = Property<ExpenseType?>(nil)
    private(set) var amountString = Property<String?>(nil)
    private(set) var labelString = Property<String?>("")

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
        labelString.value = formattedLabel

        // Setup bindings
        amountString.observeNext { [weak self] amountString in
            guard let weakSelf = self else { return }

            weakSelf.amount = weakSelf.convert(rawAmount: amountString)
            weakSelf.labelString.value = weakSelf.formattedLabel
        }.disposeIn(rBag)

        expenseType.observeNext { [weak self] amountString in
            guard let weakSelf = self else { return }
            
            weakSelf.labelString.value = weakSelf.formattedLabel
        }.disposeIn(rBag)
    }

    // MARK: - Validation

    var valid: Bool {
        return amount > 0
    }

    // MARK: - Creation

    func save() {
        guard let expenseType = expenseType.value where amount > 0 else {
            printError("Incorrect input")
            return
        }

        let expense = Expense(expenseType: expenseType)
        expense.amount = amount
        expense.createdAt = NSDate()

        printBreadcrumb("💰Saving", expense.expenseType?.name, expense.amount, expense.createdAt)
        try! DatabaseHandler.shared.save(expense: expense)

        amountString.value = "0"
        self.expenseType.value = nil
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

}