//
//  TypeSelectionTableViewController.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 25/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

class TypeSelectionTableViewController: UITableViewController {
    
    // MARK: - View model
    
    private let viewModel = TypeSelectionTableViewModel()
    
    // MARK: - View flow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.reload()
    }
    
}
