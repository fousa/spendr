//
//  ExpenseTypeSelectionTableViewController.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 25/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit
import ReactiveKit
import ReactiveUIKit

protocol ExpenseTypeSelectionTableViewControllerDelegate {

    func expenseTypeSelectionControllerDidCancel(controller: ExpenseTypeSelectionTableViewController)
    func expenseTypeSelectionController(controller: ExpenseTypeSelectionTableViewController, didSelect expenseType: ExpenseType)

}

class ExpenseTypeSelectionTableViewController: UITableViewController {

    // MARK: - Delegate

    var delegate: ExpenseTypeSelectionTableViewControllerDelegate?
    
    // MARK: - View model
    
    private let viewModel = ExpenseTypeSelectionTableViewModel()
    
    // MARK: - View flow
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup bindings.
        viewModel.title.bindTo(navigationItem.rTitle)
        viewModel.expenseTypes.bindTo(tableView, animated: false) { [weak self] indexPath, expenseTypes, tableView -> UITableViewCell in
            guard let weakSelf = self else { return UITableViewCell() }

            let cell = weakSelf.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
            let expenseType = expenseTypes[indexPath.row]
            cell.textLabel?.text = expenseType.name
            cell.detailTextLabel?.text = expenseType.period
            return cell
        }
    }

    // MARK: - Table

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let expenseType = viewModel.expenseTypes.value[indexPath.row]
        delegate?.expenseTypeSelectionController(self, didSelect: expenseType)
    }

    // MARK: - Actions

    @IBAction func cancel(sender: AnyObject) {
        delegate?.expenseTypeSelectionControllerDidCancel(self)
    }
    
}
