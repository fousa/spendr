//
//  InputViewController.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 23/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit
import ReactiveUIKit
import Delirium
import Stella

class InputViewController: UIViewController {

    // MARK: - Data

    var expenseType: ExpenseType!

    // MARK: - Outlets

    @IBOutlet var hiddenTextField: UITextField!
    @IBOutlet var amountLabel: UILabel!

    // MARK: - View model

    private let viewModel = InputViewModel()

    // MARK: - View flow

    override func viewDidLoad() {
        super.viewDidLoad()

        title = expenseType.name
        hiddenTextField.becomeFirstResponder()

        // Setup bindings.
        viewModel.amountFormatted.bindTo(amountLabel.rText)
        hiddenTextField.rText.bindTo(viewModel.amountString)
    }

    // MARK: - Actions

    @IBAction func save(sender: AnyObject) {
        if viewModel.valid {
            viewModel.save(expenseType: expenseType) { error in
                if let _ = error {
                    self.error()
                } else {
                    self.success()
                }
            }
        } else {
            error()
        }
    }

    // MARK: - Handling

    private func success() {
        dispatch_on_main {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }

    private func error() {
        amountLabel.shake()
    }

}
