//
//  DashboardViewController.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 01/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var label: UILabel!
    
    // MARK: - View flow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let amount = "18.000,00 €"
        label.text = "I spent\n\(amount)\nthis month"
        
        let attributes = [
            NSForegroundColorAttributeName: UIColor(red:0.92,green:0.36,blue:0.33,alpha:1.00)
        ]
        label.attributedText?.add(attributes: attributes, forSubstring: amount)
    }
    
    // MARK: - Status bar 
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}