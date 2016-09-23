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

            let cell = weakSelf.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ExpenseTableViewCell
            
            let expenseRecord = expenses[indexPath.row]
            let expenseType = weakSelf.viewModel.expenseType(forExpense: expenseRecord)
            cell.configure(expense: expenseRecord, expenseType: expenseType)

            return cell
        }
    }

}