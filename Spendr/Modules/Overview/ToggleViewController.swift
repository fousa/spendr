//
//  ToggleViewController.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 11/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

class ToggleViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var overviewContainerView: UIView!
    @IBOutlet weak var budgetContainerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    // MARK: - View flow

    override func viewDidLoad() {
        super.viewDidLoad()

        segmentedControl.addTarget(self, action: #selector(ToggleViewController.toggleContainer(_:)), forControlEvents: .ValueChanged)
    }

    // MARK: - Actions

    @IBAction func toggleContainer(sender: AnyObject) {
        if let segmentedControl = sender as? UISegmentedControl {
            UIView.animateWithDuration(0.35) {
                let overviewSelected = segmentedControl.selectedSegmentIndex == 0
                self.overviewContainerView.alpha = overviewSelected ? 1.0 : 0.0
                self.budgetContainerView.alpha = overviewSelected ? 0.0 : 1.0
            }
        }
    }

}
