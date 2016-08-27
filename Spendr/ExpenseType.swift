//
//  ExpenseType.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 27/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import Foundation
import CloudKit

struct ExpenseType {

    private(set) var name: String
    private(set) var period: String
    private(set) var record: CKRecord

    init?(record: CKRecord) {
        guard let
            name = record["name"] as? String,
            period = record["period"] as? String else {
            return nil
        }

        self.record = record
        self.name = name
        self.period = period
    }

}