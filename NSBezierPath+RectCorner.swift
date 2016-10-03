//
//  NSBezierPath+RectCorner.swift
//  SuperWriting
//
//  Created by 慧趣小歪 on 16/8/27.
//  Copyright © 2016年 yFenFen. All rights reserved.
//

import Cocoa

public struct NSRectCorner : OptionSet {
    
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
            move(to: NSMakePoint(rect.minX + cornerRadii.width, rect.minY))
            //self.appendBezierPathWithArcFromPoint(NSPoint, toPoint: <#T##NSPoint#>, radius: <#T##CGFloat#>)
            appendArc(withCenter: NSMakePoint(rect.minX + cornerRadii.width, rect.minY + cornerRadii.height), radius: cornerRadii.width, startAngle: 270, endAngle: 180, clockwise: true)
        } else {
            move(to: NSMakePoint(rect.minX, rect.minY))
        }
        
        if corners.contains(.TopLeft) {
            line(to: NSMakePoint(rect.minX, rect.maxY - cornerRadii.height))
            appendArc(withCenter: NSMakePoint(rect.minX + cornerRadii.width, rect.maxY - cornerRadii.height), radius: cornerRadii.width, startAngle: 180, endAngle: 90, clockwise: true)
        } else {
            line(to: NSMakePoint(rect.minX, rect.maxY))
        }
        
        if corners.contains(.TopRight) {
            line(to: NSMakePoint(rect.maxX - cornerRadii.width, rect.maxY))
            appendArc(withCenter: NSMakePoint(rect.maxX - cornerRadii.width, rect.maxY - cornerRadii.height), radius: cornerRadii.width, startAngle: 90, endAngle: 0, clockwise: true)
        } else {
            line(to: NSMakePoint(rect.maxX, rect.maxY))
        }
        
        if corners.contains(.BottomRight) {
            line(to: NSMakePoint(rect.maxX, rect.minY + cornerRadii.height))
            appendArc(withCenter: NSMakePoint(rect.maxX - cornerRadii.width, rect.minY + cornerRadii.height), radius: cornerRadii.width, startAngle: 0, endAngle: 270, clockwise: true)
        } else {
            line(to: NSMakePoint(rect.maxX, rect.minY))
        }
        close()
    }
    
    var cgPath:CGPath? {
        if elementCount == 0 { return nil }
        var didClosePath:Bool = true
        let path:CGMutablePath = CGMutablePath()
        var points:[NSPoint] = [NSMakePoint(0, 0),NSMakePoint(0, 0),NSMakePoint(0, 0)]
        //var transform:CGAffineTransform = CGAffineTransform()
        for i in 0..<elementCount {
            switch element(at: i, associatedPoints: &points) {
            case .moveToBezierPathElement:
                path.move(to: points[0])
                //CGPathMoveToPoint(path, &transform, points[0].x, points[0].y)
            case .lineToBezierPathElement:
                path.addLine(to: points[0])
                //CGPathAddLineToPoint(path, &transform, points[0].x, points[0].y)
                didClosePath = false
            case .curveToBezierPathElement:
                path.addCurve(to: points[0], control1: points[1], control2: points[2])
//                CGPathAddCurveToPoint(path, &transform,
//                                      points[0].x, points[0].y,
//                                      points[1].x, points[1].y,
//                                      points[2].x, points[2].y)
                didClosePath = false
            case .closePathBezierPathElement:
                path.closeSubpath()
                didClosePath = true
            }
        }
        if !didClosePath {
            path.closeSubpath()
        }
        return path.copy()
    }
}
//class NSBezierPath_RectCorner {
//
//}
