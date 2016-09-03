//
//  NSBezierPath+RectCorner.swift
//  SuperWriting
//
//  Created by 慧趣小歪 on 16/8/27.
//  Copyright © 2016年 yFenFen. All rights reserved.
//

import Cocoa

public struct NSRectCorner : OptionSetType {
    
    public let rawValue: UInt
    public init(rawValue: UInt) { self.rawValue = rawValue }
    
    public static var NoneCorners: NSRectCorner { return NSRectCorner(rawValue: 0) }
    public static var TopLeft: NSRectCorner     { return NSRectCorner(rawValue: 1 << 0) }
    public static var TopRight: NSRectCorner    { return NSRectCorner(rawValue: 1 << 1) }
    public static var BottomLeft: NSRectCorner  { return NSRectCorner(rawValue: 1 << 2) }
    public static var BottomRight: NSRectCorner { return NSRectCorner(rawValue: 1 << 3) }
    public static var AllCorners: NSRectCorner  { return [.TopLeft, .TopRight, .BottomLeft, .BottomRight] }
}

extension NSBezierPath {
    
    
    public convenience init(roundedRect rect: CGRect, byRoundingCorners corners: NSRectCorner, cornerRadii: CGSize) {
        self.init()
        if corners.contains(.BottomLeft) {
            moveToPoint(NSMakePoint(rect.minX + cornerRadii.width, rect.minY))
            //self.appendBezierPathWithArcFromPoint(NSPoint, toPoint: <#T##NSPoint#>, radius: <#T##CGFloat#>)
            appendBezierPathWithArcWithCenter(NSMakePoint(rect.minX + cornerRadii.width, rect.minY + cornerRadii.height), radius: cornerRadii.width, startAngle: 270, endAngle: 180, clockwise: true)
        } else {
            moveToPoint(NSMakePoint(rect.minX, rect.minY))
        }
        
        if corners.contains(.TopLeft) {
            lineToPoint(NSMakePoint(rect.minX, rect.maxY - cornerRadii.height))
            appendBezierPathWithArcWithCenter(NSMakePoint(rect.minX + cornerRadii.width, rect.maxY - cornerRadii.height), radius: cornerRadii.width, startAngle: 180, endAngle: 90, clockwise: true)
        } else {
            lineToPoint(NSMakePoint(rect.minX, rect.maxY))
        }
        
        if corners.contains(.TopRight) {
            lineToPoint(NSMakePoint(rect.maxX - cornerRadii.width, rect.maxY))
            appendBezierPathWithArcWithCenter(NSMakePoint(rect.maxX - cornerRadii.width, rect.maxY - cornerRadii.height), radius: cornerRadii.width, startAngle: 90, endAngle: 0, clockwise: true)
        } else {
            lineToPoint(NSMakePoint(rect.maxX, rect.maxY))
        }
        
        if corners.contains(.BottomRight) {
            lineToPoint(NSMakePoint(rect.maxX, rect.minY + cornerRadii.height))
            appendBezierPathWithArcWithCenter(NSMakePoint(rect.maxX - cornerRadii.width, rect.minY + cornerRadii.height), radius: cornerRadii.width, startAngle: 0, endAngle: 270, clockwise: true)
        } else {
            lineToPoint(NSMakePoint(rect.maxX, rect.minY))
        }
        closePath()
    }
    
    var cgPath:CGPath? {
        if elementCount == 0 { return nil }
        var didClosePath:Bool = true
        let path:CGMutablePath? = CGPathCreateMutable()
        var points:[NSPoint] = [NSMakePoint(0, 0),NSMakePoint(0, 0),NSMakePoint(0, 0)]
        for i in 0..<elementCount {
            switch elementAtIndex(i, associatedPoints: &points) {
            case .MoveToBezierPathElement:
                CGPathMoveToPoint(path, nil, points[0].x, points[0].y)
            case .LineToBezierPathElement:
                CGPathAddLineToPoint(path, nil, points[0].x, points[0].y)
                didClosePath = false
            case .CurveToBezierPathElement:
                CGPathAddCurveToPoint(path, nil,
                                      points[0].x, points[0].y,
                                      points[1].x, points[1].y,
                                      points[2].x, points[2].y)
                didClosePath = false
            case .ClosePathBezierPathElement:
                CGPathCloseSubpath(path)
                didClosePath = true
            }
        }
        if !didClosePath {
            CGPathCloseSubpath(path)
        }
        return CGPathCreateCopy(path)
    }
}
//class NSBezierPath_RectCorner {
//
//}
