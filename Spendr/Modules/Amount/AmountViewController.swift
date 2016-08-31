//
//  AmountViewController.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 31/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

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

        hiddenTextField.becomeFirstResponder()

        // Bind the hidden textfield to the amount string in the view model.
        hiddenTextField.rText.bindTo(viewModel.amountString)

        // Bind the label text of the viewmodel to be observed.
        viewModel.labelString.observeNext { text in
            self.label.text = text
            self.label.boldify(substring: self.viewModel.formattedAmount)
            self.label.boldify(substring: self.viewModel.formattedExpenseType)
            self.label.tapify(substring: self.viewModel.formattedExpenseType) {
                print("Tapped expense type")
            }
        }.disposeIn(rBag)
    }

    // MARK: - Actions

    @IBAction func save(sender: AnyObject) {
        if viewModel.valid {
            viewModel.save(expenseType: expenseType)
        } else {
        }
    }
    
}