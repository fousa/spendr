//
//  TypeSelectionTableViewController.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 25/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit
import ReactiveKit
import ReactiveUIKit

class TypeSelectionTableViewController: UITableViewController {
    
    // MARK: - View model
    
    private let viewModel = TypeSelectionTableViewModel()
    
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
        }.disposeIn(rBag)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let
            selectedIndexPath = tableView.indexPathForSelectedRow,
            controller = segue.destinationViewController as? DateSelectionViewController {
            let expenseType = viewModel.expenseTypes.value[selectedIndexPath.row]
            controller.expenseType = expenseType
        }
    }
    
}
