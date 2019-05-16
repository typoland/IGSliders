//
//  IGSlidersController + StyleValues.swift
//  IGSliders
//
//  Created by Łukasz Dziedzic on 16/05/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

extension IGSlidersController {
    @objc dynamic var currentStyleValues: [NSNumber] {
        get {
            guard let values = currentStyle?.egdesValues else {
                return []
            }
            return values.map {NSNumber(value: $0)}
        }
        set {
            print ("setting currentStyleValues", currentStyle, currentStyle?.egdesValues, newValue )
            guard let style = currentStyle else {return}
            print (newValue)
            style.egdesValues = newValue.map {$0.doubleValue}
        }
    }
    
    
    
    @objc var selectedStyleValuesCount:Int {
        guard selectedAxisIndex > -1, selectedStyleIndex > -1 else {return -1}
        return sliders.axes[selectedAxisIndex].styles[selectedStyleIndex].egdesValues.count
    }
}
