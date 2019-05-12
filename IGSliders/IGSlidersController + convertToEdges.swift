//
//  IGSlidersController + convertToEdges.swift
//  IGSliders
//
//  Created by Łukasz Dziedzic on 12/05/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import EdgesFramework



extension IGSlidersController {
    
    typealias EFStyle = EdgesFramework.MultidimensionalStyle
    
    func coordinates() -> [(name: String, values:[Double])] {
        var result = [EFStyle]()
        func deep (axisNr:Int = 0, styles: [IGSlidersView.Style] = []) {
            if axisNr < sliders.axes.count {
                for style in sliders.axes[axisNr].styles {
                    deep (axisNr: axisNr + 1, styles: styles + [style])
                }
            } else {
                styles.forEach({print ($0.name, $0.egdesValues)})
                let mStyle = EFStyle(styles.map{$0.name},
                                     styles.map{$0.egdesValues})
                result.append(mStyle)
            }
            
        }
        deep()

        return result.map {(name:$0.name, values: $0.coordinates)}
    }
}
