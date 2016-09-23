//
//  BudgetTableViewCell.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 11/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//


import UIKit
import CloudKit

class BudgetTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet var expenseTypeLabel: UILabel!
    @IBOutlet var expenseAmountLabel: UILabel!

    // MARK: - Configure

    func configure(expenseType expenseType: ExpenseType) {
        expenseTypeLabel.text = expenseType.name
        expenseAmountLabel.text = format(amount: expenseType.amount)
    }

    // MARK: - Formatting

    private lazy var formatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter
    }()

    private func format(amount amount: Double) -> String {
        return formatter.stringFromNumber(amount)!
    }

}