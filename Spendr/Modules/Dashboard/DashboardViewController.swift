//
//  DashboardViewController.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 01/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    // MARK: - View Model

    private let viewModel = DashboardViewModel()
    
    // MARK: - Outlets
    
    @IBOutlet var label: UILabel!
    
    // MARK: - View flow
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.amount.observeNext { amount in
            self.label.text = self.viewModel.title

            let attributes = [
                NSFontAttributeName: UIFont.systemFontOfSize(self.label.font.pointSize, weight: UIFontWeightMedium)
            ]
            let formattedAmount = self.viewModel.formattedAmount
            self.label.attributedText?.add(attributes: attributes, forSubstring: formattedAmount)
        }.disposeIn(rBag)
    }
    
    // MARK: - Status bar 
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    // MARK: - Segue

    @IBAction func unwindToDashboard(segue: UIStoryboardSegue) {
    }
    
}