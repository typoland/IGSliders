//
//  IGSlidersController readWriteDefaults.swift
//  IGSliders
//
//  Created by Łukasz Dziedzic on 02/05/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

public extension IGSlidersController {
    
    @IBAction func saveToDefaults(_ sender:Any) {
        let archiver = JSONEncoder.init()
        guard let data = try? archiver.encode(sliders.axes) else {return}
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: "SavedAxes")
    }

    @IBAction func readFromDefaults(_ sender:Any) {
        willChangeValue(for: \IGSlidersController.axesNames)
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: "SavedAxes") as? Data else { return }
        let decoder = JSONDecoder()
        if let axes = try? decoder.decode([IGSlidersView.Axis].self, from: data) {
            sliders.axes = axes
            selectedAxisIndex = axes.count>0 ? 0 : -1
        }
        print ("read")
        sliders.axes.forEach({axis in
            print (axis.name)
            print (axis.selectedStyleIndex)
            axis.styles.forEach {style in
                print (style.name, style.egdesValues.count)
            }
        })
       didChangeValue(for: \IGSlidersController.axesNames)
    }
}
