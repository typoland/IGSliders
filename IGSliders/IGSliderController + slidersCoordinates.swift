//
//  IGSliderController + slidersCoordinates.swift
//  IGSliders
//
//  Created by Łukasz Dziedzic on 17/05/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

extension IGSlidersController {
    var slidersCoordinates:[[[(styleName:String, value:Double)]]] {
        
        //Very error prone!
        let edgesNr = sliders.axes[0].styles[0].egdesValues.count
        print ("°", edgesNr )
        let edgesArray = Array(repeating: [(styleName:String, value:Double)](), count: edgesNr)
        var result : [[[(styleName:String, value:Double)]]] =  Array(repeating: edgesArray, count: sliders.axes.count)
        for axisNr in 0 ..< sliders.axes.count {
            for edgeNr in 0 ..< edgesNr {
                for styleNr in 0 ..< sliders.axes[axisNr].styles.count {
                    let name = sliders.axes[axisNr].styles[styleNr].name
                    let value = sliders.axes[axisNr].styles[styleNr].egdesValues[edgeNr]
                    result[axisNr][edgeNr].append((styleName:name, value:value))
                }
            }
        }
        print (result)
        return result
    }
}
