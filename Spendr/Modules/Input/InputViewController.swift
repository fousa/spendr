//
//  InputViewController.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 23/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

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

        hiddenTextField.becomeFirstResponder()
    }

}

extension InputViewController: UITextFieldDelegate {

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let amountText: NSString = (textField.text ?? "") as NSString
        viewModel.amountString = amountText.stringByReplacingCharactersInRange(range, withString: string)
        amountLabel.text = viewModel.amountString
        return true
    }

}
