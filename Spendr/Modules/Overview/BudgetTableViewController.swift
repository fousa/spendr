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
        viewModel.expenseTypes.bindTo(tableView, animated: false) { [weak self] indexPath, expenseTypes, tableView -> UITableViewCell in
            guard let weakSelf = self else { return UITableViewCell() }

            let cell = weakSelf.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! BudgetTableViewCell

            let expenseType = expenseTypes[indexPath.row]
            cell.configure(expenseType: expenseType)

            return cell
        }
    }

}
