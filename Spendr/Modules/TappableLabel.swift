//
//  TappableLabel.swift
//  Spendr
//
//  Created by Jelle Vandebeeck on 31/08/16.
//  Copyright © 2016 Fousa. All rights reserved.
//

import UIKit

class TappableLabel: UILabel {
    
    // MARK: - Internals
    
    private var textRange: NSRange?
    private var block: (() -> ())?
    
    // MARK: - Tappable
    
    func tapify(substring substring: String, block: (() -> ())? = nil) {
        if let attributedText = attributedText as? NSMutableAttributedString {
            // Persist the range of the substring for later use.
            textRange = (attributedText.string as NSString).rangeOfString(substring)
            
            // Keep the completen block for when the user taps the substring.
            self.block = block
            
            // Add a tap gesture to the label and
            addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TappableLabel.tapped(_:))))
            userInteractionEnabled = true
            
            backgroundColor = UIColor.greenColor()
        }
    }
    
    // MARK: - Gestures
    
    func tapped(gesture: UITapGestureRecognizer) {
        guard let
            textRange = textRange,
            label = gesture.view as? TappableLabel else {
            return
        }
        
        // Create the layout manager to handle the different characters that are
        // displayed in the label.
        let storage = NSTextStorage(attributedString: label.attributedText!)
        let layoutManager = NSLayoutManager()
        storage.addLayoutManager(layoutManager)
        
        // The text container defines the region that layouts the text. We need this in orde
        // to find the character for a given point.
        let textContainer = NSTextContainer(size: CGSizeMake(label.frame.size.width, label.frame.size.height + 100))
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = label.numberOfLines
        textContainer.lineBreakMode = label.lineBreakMode
        layoutManager.addTextContainer(textContainer)
        
//        guard let textRange = textRange else {
//            return
//        }
        
//        var glyphRange = NSRange()
//        layoutManager.characterRangeForGlyphRange(textRange, actualGlyphRange: &glyphRange)
//        
//        // Lookup the tapped character and execute the block.
//        let rect = layoutManager.boundingRectForGlyphRange(textRange, inTextContainer: textContainer)
        
//        let location = gesture.locationOfTouch(0, inView: label)
        let location = gesture.locationInView(label)
//        if CGRectContainsPoint(rect, location) {
//            block?()
//        }
        
        
        
        let characterIndex = layoutManager.characterIndexForPoint(location, inTextContainer: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        print("characterIndex", characterIndex)
        print("textRange.location", textRange.location)
        print("textRange.length", textRange.length)
        
        print("-- in range", NSLocationInRange(characterIndex, textRange))
        if characterIndex > textRange.location {
            block?()
        }
    }
    
}
