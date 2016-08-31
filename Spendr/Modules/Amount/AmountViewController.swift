//
//  AmountViewController.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 31/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit
import Stella

class AmountViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet var hiddenTextField: UITextField!
    @IBOutlet var label: TappableLabel!

    // MARK: - Data

    private var expenseType: ExpenseType!

    // MARK: - View model

    private let viewModel = AmountViewModel()

    // MARK: - View flow
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Bind the hidden textfield to the amount string in the view model.
        hiddenTextField.rText.bindTo(viewModel.amountString)

        // Bind the label text of the viewmodel to be observed.
        viewModel.labelString.observeNext { text in
            self.label.text = text
            self.label.boldify(substring: self.viewModel.formattedAmount)
            self.label.boldify(substring: self.viewModel.formattedExpenseType)
            self.label.tapify(substring: self.viewModel.formattedExpenseType) {
                self.presentExpenseTypeSelection()
            }
        }.disposeIn(rBag)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        hiddenTextField.becomeFirstResponder()
    }

    // MARK: - Actions

    @IBAction func save(sender: AnyObject) {
        viewModel.save()
    }

    // MARK: - Presenting

    private func presentExpenseTypeSelection() {
        printAction("Present the expense type selection")

        let storyboard = UIStoryboard(name: "ExpenseTypeSelection", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let controller = navigationController.topViewController as! ExpenseTypeSelectionTableViewController
        controller.delegate = self
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
}

extension AmountViewController: ExpenseTypeSelectionTableViewControllerDelegate {

    func expenseTypeSelectionControllerDidCancel(controller: ExpenseTypeSelectionTableViewController) {
        printAction("Cancel the expense type selection")
        dismissViewControllerAnimated(true, completion: nil)
    }

    func expenseTypeSelectionController(controller: ExpenseTypeSelectionTableViewController, didSelect expenseType: ExpenseType) {
        printAction("Select the expense type", expenseType.name)
        viewModel.expenseType.value = expenseType
        dismissViewControllerAnimated(true, completion: nil)
    }

}