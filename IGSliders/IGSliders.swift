//
//  IGSliders.swift
//  IGSliders
//
//  Created by Łukasz Dziedzic on 15/05/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

//
//  IGSliders.swift
//
//
//  Created by Łukasz Dziedzic on 29/04/2019.
//

import Foundation
import AppKit


public class IGSliders:NSObject {
    
    typealias CoordUnit = Double
    
    var axes:[Axis] = []

    
    func addAxis() {
        axes.append(Axis())
        for axisNr in 0 ..< axes.count {
            for styleNr in 0..<axes[axisNr].styles.count {
                
                let values = axes[axisNr].styles[styleNr].egdesValues
                axes[axisNr].styles[styleNr].egdesValues = values + values
                
            }
        }
        
    }
    
    func removeAxis(_ axisIndex:Int) {
        axes.remove(at: axisIndex)
        axes.forEach { axis in
            axis.styles.forEach { style in
                let egdesValues = style.egdesValues
                style.egdesValues = Array(egdesValues[0..<egdesValues.count/2])
            }
        }
    }

    
    func addStyle(to axis:Axis) {
        //guard let axis = currentAxis else {return}
        let newStyle = Style()
        let defaultValue = axis.default
        //TO DO recalculate default value to 0...1
        newStyle.egdesValues = Array(
            repeating: defaultValue,
            count: 1 << (axes.count - 1))
        axis.styles.append(newStyle)
        
        //
    }
    
    func removeStyle(from axis:Axis, style index:Int) {
        axis.styles.remove(at: index)
        
    }
}
