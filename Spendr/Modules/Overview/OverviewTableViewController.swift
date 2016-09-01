//
//  OverviewTableViewController.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 01/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit
import ReactiveKit
import ReactiveUIKit
import CloudKit

class OverviewTableViewController: UITableViewController {

    // MARK: - View model

    private let viewModel = OverviewTableViewModel()

    // MARK: - View flow

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup bindings.
        viewModel.expenses.bindTo(tableView, animated: false) { [weak self] indexPath, expenses, tableView -> UITableViewCell in
            guard let weakSelf = self else { return UITableViewCell() }

            let cell = weakSelf.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
            let expenseRecord = expenses[indexPath.row]

            cell.textLabel?.text = String(expenseRecord["date"] as! NSDate)

            let amount = expenseRecord["amount"] as! Double
            cell.detailTextLabel?.text = weakSelf.format(amount: amount)
            return cell
        }
    }

    // MARK: - Status bar

    override func prefersStatusBarHidden() -> Bool {
        return true
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