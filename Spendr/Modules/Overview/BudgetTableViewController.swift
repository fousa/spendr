//
//  BudgetTableViewController.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 11/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

class BudgetTableViewController: UITableViewController {

    // MARK: - View model

    private let viewModel = BudgetTableViewModel()

    // MARK: - View flow

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup bindings.
        viewModel.expenses.bindTo(tableView, animated: false) { [weak self] indexPath, expenses, tableView -> UITableViewCell in
            guard let weakSelf = self else { return UITableViewCell() }

            let cell = weakSelf.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! BudgetTableViewCell

            let expenseRecord = expenses[indexPath.row]
            let expenseType = weakSelf.viewModel.expenseType(forExpense: expenseRecord)
            cell.configure(expense: expenseRecord, expenseType: expenseType)

            return cell
        }
    }

}
