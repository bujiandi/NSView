//
//  NSGradientView.swift
//  SuperWriting
//
//  Created by 慧趣小歪 on 16/8/27.
//  Copyright © 2016年 yFenFen. All rights reserved.
//

import Cocoa

@IBDesignable
class NSGradientView: NSView {
    
    @IBInspectable var startingColor:NSColor = NSColor(white: 0.77, alpha: 1) {
        didSet {
            backgroundGradient = NSGradient(starting: startingColor, ending: endingColor)!
        }
    }
    @IBInspectable var endingColor  :NSColor = NSColor(white: 0.92, alpha: 1) {
        didSet {
            backgroundGradient = NSGradient(starting: startingColor, ending: endingColor)!
        }
    }
    
    fileprivate var backgroundGradient = NSGradient(starting:
        NSColor(white: 0.77, alpha: 1), ending:
        NSColor(white: 0.92, alpha: 1))!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        backgroundGradient.draw(in: bounds, angle: 90)
        // Drawing code here.
    }
    
}
