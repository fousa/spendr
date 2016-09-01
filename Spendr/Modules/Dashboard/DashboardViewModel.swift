//
//  DashboardViewModel.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 01/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit
import ReactiveKit
import RealmSwift
import Stella

class DashboardViewModel {

    // MARK: - Properties

    private(set) var amount = ReactiveKit.Property<Double>(0)

    // MARK: - Init

    init() {
        CloudHandler.shared.totalAmount.bindTo(amount)
    }

    // MARK: - Label

    var formattedAmount: String {
        return format(amount: amount.value)
    }

    var title: String {
        return "You spent\n\(formattedAmount)\nthis month"
    }

    // MARK: - Formatting

    private lazy var formatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter
    }()

    private func format(amount amount: Double) -> String {
        return formatter.stringFromNumber(amount)!
    }

}