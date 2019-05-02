//
//  IGSlidersController InsertViewInto.swift
//  IGSliders
//
//  Created by Łukasz Dziedzic on 01/05/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

public extension IGSlidersController {
    func insertViewInto(_ parentView:NSView) {
        parentView.addSubview(self.view)
        self.view.frame = NSMakeRect(0, 0, parentView.frame.width, parentView.frame.height)
    }
}
