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
            backgroundGradient = NSGradient(startingColor: startingColor, endingColor: endingColor)!
        }
    }
    @IBInspectable var endingColor  :NSColor = NSColor(white: 0.92, alpha: 1) {
        didSet {
            backgroundGradient = NSGradient(startingColor: startingColor, endingColor: endingColor)!
        }
    }
    
    private var backgroundGradient = NSGradient(startingColor:
        NSColor(white: 0.77, alpha: 1), endingColor:
        NSColor(white: 0.92, alpha: 1))!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        backgroundGradient.drawInRect(bounds, angle: 90)
        // Drawing code here.
    }
    
}
