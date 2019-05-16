//
//  IGSlidersController + StyleValues.swift
//  IGSliders
//
//  Created by Łukasz Dziedzic on 16/05/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

extension IGSlidersController {
    
    class Value:NSObject {
        @objc dynamic var value: NSNumber {
            willSet { willChangeValue(for: \Value.value) }
            didSet { didChangeValue(for: \Value.value) }
        }
        init (_ value:Double) {
            self.value = NSNumber(value:value)
            
        }
        override var description: String {
            return String(format: "%1.3f", value.floatValue)
        }
    }
    
    @objc dynamic var currentStyleValues: [Value]  {
        get {
            guard let values = currentStyle?.egdesValues else {
                return []
            }
            return values.map {Value($0)}
        }
        set {
            print ("setting currentStyleValues", currentStyle, currentStyle?.egdesValues, newValue )
            guard let style = currentStyle else {return}
            print (newValue)
            //.egdesValues = newValue.map {$0.doubleValue}
        }
    }
    
    
    
    @objc var selectedStyleValuesCount:Int {
        guard selectedAxisIndex > -1, selectedStyleIndex > -1 else {return -1}
        return sliders.axes[selectedAxisIndex].styles[selectedStyleIndex].egdesValues.count
    }
}
