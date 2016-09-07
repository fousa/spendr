//
//  AppDelegate.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 23/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit
import Duvel
import Seam
import CoreData

enum ShortcutIdentifier: String {
    case AddExpense = "add"
    
    init?(identifier: String) {
        guard let shortIdentifier = identifier.componentsSeparatedByString(".").last else {
            return nil
        }
        self.init(rawValue: shortIdentifier)
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var duvel: Duvel!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setupCoreData()

        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            handle(shortcut: shortcutItem)
            return false
        }
        
        return true
    }

    func applicationDidBecomeActive(application: UIApplication) {
        CloudHandler.shared.fetchExpenseTypes()
        CloudHandler.shared.fetchExpenses(forMonth: NSDate())
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        completionHandler(handle(shortcut: shortcutItem))
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        if let seamStore = duvel.persistentStoreCoordinator?.persistentStores.first as? SMStore {
            print("userInfo \(userInfo)")
            seamStore.handlePush(userInfo: userInfo)
        }
    }

    // MARK: - Core Data

    private func setupCoreData() {
        duvel = try! Duvel(storeType: SeamStoreType)
        if let seamStore = duvel.persistentStoreCoordinator?.persistentStores.first as? SMStore {
            seamStore.triggerSync()
        }

        duvel.mainContext.perform(changes: { context in
            Category.create(inContext: context) { category in
                category.name = "test"
            }
        })

    }
    
    // MARK: - Shortcuts
    
    private func handle(shortcut item: UIApplicationShortcutItem) -> Bool {
        guard let identifier = ShortcutIdentifier(identifier: item.type) where identifier == .AddExpense else {
            return false
        }
        
        guard let controller = window?.rootViewController as? DashboardViewController else {
            return false
        }
        
        controller.dismissViewControllerAnimated(false, completion: nil)
        controller.performSegueWithIdentifier("Add", sender: nil)
        
        return true
    }
    
}
