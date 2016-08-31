//
//  TypeSelectionTableViewModel.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 25/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import ReactiveKit
import RealmSwift
import Stella

class ExpenseTypeSelectionTableViewModel {

    // MARK: - Properties

    private(set) var title = ReactiveKit.Property<String>("Selecteer een type")
    private(set) var expenseTypes = CollectionProperty<[ExpenseType]>([])

    // MARK: - Internals

    private var notificationToken: NotificationToken?

    // MARK: - Init

    init() {
        notificationToken = DatabaseHandler.shared.expenseTypes.addNotificationBlock { results in
            let expenseTypes = DatabaseHandler.shared.expenseTypes
            printBreadcrumb("💡UI", expenseTypes.count)
            self.expenseTypes.replace(Array(expenseTypes))
        }
    }

    deinit {
        notificationToken?.stop()
    }

}