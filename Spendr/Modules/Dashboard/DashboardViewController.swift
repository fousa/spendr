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
        label.attributedText?.add(attributes: [NSFontAttributeName: UIFont.systemFontOfSize(label.font.pointSize, weight: UIFontWeightBold)], forSubstring: amount)
    }
    
    // MARK: - Status bar 
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}