//
//  DateSelectionViewController.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 23/09/2016.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit
import ReactiveUIKit

class DateSelectionViewController: UIViewController {
    
    // MARK: - View model
    
    private let viewModel = DateSelectionViewModel()
    
    // MARK: - Data
    
    var expenseType: ExpenseType!
    
    // MARK: - Outlets
    
    @IBOutlet var datePicker: UIDatePicker!
    
    // MARK: - View flow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup bindings.z
        datePicker.rDate.bindTo(viewModel.date)
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? InputViewController {
            controller.expenseType = expenseType
            controller.date = viewModel.date.value
        }
    }

}
