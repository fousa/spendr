//
//  ExpenseType.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 27/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import CloudKit
import Realm
import RealmSwift

enum ExpenseTypeError: ErrorType {
    case invalidJSON
}

class ExpenseType: Object {

    // MARK: - Properties

    dynamic var name: String = ""
    dynamic var period: String = ""
    dynamic var recordName: String = ""

    // MARK: - Init

    convenience init(record: CKRecord) throws {
        guard let
            name = record["name"] as? String,
            period = record["period"] as? String else {
                throw ExpenseTypeError.invalidJSON
        }

        self.init()

        self.recordName = record.recordID.recordName
        self.name = name
        self.period = period
    }

    // MARK: - Overrides

    override static func primaryKey() -> String? {
        return "recordName"
    }

}