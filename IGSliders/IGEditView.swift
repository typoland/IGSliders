//
//  IGVIew.swift
//  IGSliders
//
//  Created by Łukasz Dziedzic on 01/05/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

public class IGEditView: NSView {
    public override func awakeFromNib() {
        print ("AWAKEN ")
    }
    
    public override func draw(_ dirtyRect: NSRect) {
        NSColor.red.setFill()
        NSBezierPath.init(rect: dirtyRect).fill()
    }
}

extension NSView {
    
    public func addConstaintsToSuperview(leftOffset: CGFloat, topOffset: CGFloat) {
        
        //self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .leading,
                           multiplier: 1,
                           constant: leftOffset).isActive = true
        
        NSLayoutConstraint(item: self,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .top,
                           multiplier: 1,
                           constant: topOffset).isActive = true
    }
    
    public func addConstaints(height: CGFloat, width: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = true
        
        NSLayoutConstraint(item: self,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: height).isActive = true
        
        
        NSLayoutConstraint(item: self,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: width).isActive = true
    }
}
