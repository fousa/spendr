//
//  UILabel+Bold.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 31/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

extension UILabel {
    
    func boldify(substring substring: String) {
        if let attributedText = attributedText as? NSMutableAttributedString {
            // Lookup the range of the given substring.
            let range = (attributedText.string as NSString).rangeOfString(substring)
            let currentFont = UIFont.systemFontOfSize(font.pointSize, weight: UIFontWeightBold)
            attributedText.addAttribute(NSFontAttributeName, value: currentFont, range: range)
        }
    }
    
}