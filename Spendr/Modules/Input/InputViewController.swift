//
//  InputViewController.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 23/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit
import ReactiveUIKit

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
        navigationController?.popToRootViewControllerAnimated(true)
    }

}
