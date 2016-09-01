//
//  NSAttributedString+Substring.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 01/09/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    func add(attributes attributes: [String: AnyObject], forSubstring substring: String) {
        if let attributedString = self as? NSMutableAttributedString {
            // Lookup the range of the given substring.
            let range = (attributedString.string as NSString).rangeOfString(substring)
            attributedString.addAttributes(attributes, range: range)
        }
    }
    
}