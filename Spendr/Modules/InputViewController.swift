//
//  InputViewController.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 23/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet var hiddenTextField: UITextField!

    // MARK: - View flow

    override func viewDidLoad() {
        super.viewDidLoad()

        hiddenTextField.becomeFirstResponder()
    }

}
