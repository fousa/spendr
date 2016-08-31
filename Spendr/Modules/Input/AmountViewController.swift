//
//  AmountViewController.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 31/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

class AmountViewController: UIViewController {
    
    @IBOutlet var label: TappableLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let amount = "100,00 €"
        let category = "soaring"
        self.label.text = "I\nspent\n\(amount)\non my \(category)\nbudget"
        self.label.boldify(substring: amount)
        self.label.boldify(substring: category)
        
//        self.label.tapify(substring: amount) {
//            print("Tapped amount")
//        }
        self.label.tapify(substring: category) {
            print("Tapped category")
        }
    }
    
}