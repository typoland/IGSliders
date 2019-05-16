//
//  IGSlidersController + Axis.swift
//  IGSliders
//
//  Created by Łukasz Dziedzic on 16/05/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

extension IGSlidersController {
    
    var currentAxis: IGSliders.Axis? {
        guard selectedAxisIndex >= 0 else { return nil }
        return sliders.axes [ selectedAxisIndex ]
    }
    
    @objc var axesNames: [String] {
        get {
            return sliders.axes.map { $0.name }
        }
        set {
            willChangeValue(for: \IGSlidersController.axesNames)
            (0...sliders.axes.count-1).forEach {sliders.axes[$0].name = newValue[$0]}
            didChangeValue(for: \IGSlidersController.axesNames)
            
        }
    }
    
    @objc var canAddAxis: Bool {
        return true // sliders != nil
    }
    
    @IBAction func addAxis(_ sender:Any) {
        willChangeValue(for: \IGSlidersController.axesNames)
        willChangeValue(for: \IGSlidersController.selectedAxisIndex)
        willChangeValue(for: \IGSlidersController.selectedStyleIndex)
        sliders.addAxis()
        selectedAxisIndex = sliders.axes.count - 1
        //selectedAxisIndex = sliders.selectedAxisIndex
        //selectedStyleIndex = -1
        didChangeValue(for: \IGSlidersController.selectedStyleIndex)
        didChangeValue(for: \IGSlidersController.selectedAxisIndex)
        didChangeValue(for: \IGSlidersController.axesNames)
        notifyStylesChange()
    }
    
    @objc var canRemoveAxis: Bool {
        return selectedAxisIndex >= 0
    }
    
    @IBAction func removeAxis(_ sender:Any) {
        axisDuringDeletion = true
        willChangeValue(for: \IGSlidersController.axesNames)
        willChangeValue(for: \IGSlidersController.selectedAxisIndex)
        
        sliders.removeAxis(selectedAxisIndex)
        
        selectedAxisIndex = sliders.axes.count == 1
            ? 0
            : selectedAxisIndex - 1
        
        didChangeValue(for: \IGSlidersController.selectedAxisIndex)
        didChangeValue(for: \IGSlidersController.axesNames)
        notifyStylesChange()
    }
    
    @IBAction func changeAxisName(_ sender:Any) {
        guard let control  = sender as? NSControl,
            let axis = currentAxis else {return}
        willChangeValue(for: \IGSlidersController.axesNames)
        axis.name = control.stringValue
        didChangeValue(for: \IGSlidersController.axesNames)
    }
    
    @objc var axesNamesString: String {
        //TO DO <Unnamed> to some default
        var s = axesNames.reduce(into: "",  {str, name in
            str += " \(name.count == 0 ? "<Unnamed>" : name),"
        })
        if !s.isEmpty { _ = s.removeLast() }
        return s
    }
    
    @IBAction func setSelectedAxis(_ sender:Any) {
        //print ("\nCONTROLLER set selected Axis -> \(selectedAxisIndex)")
        switch sender {
        case is NSTableView:
            selectedAxisIndex = (sender as? NSTableView)?.selectedRow ?? -1
        case is Int:
            selectedAxisIndex = (sender as? Int) ?? -1
        case is NSControl:
            let nr = Int((sender as? NSControl)?.intValue ?? -1)
            print (nr)
            let max = sliders.axes.count-1
            print ("•")
            selectedAxisIndex = nr > max ? max : nr
            print ("°", selectedAxisIndex, nr, max, nr>max)
        default: selectedAxisIndex = -1
        }
    }
    
    @objc var selectedAxisName: String {
        get {
            guard selectedAxisIndex > -1 else {return ""}
            return axesNames[selectedAxisIndex]
        }
        set {
            guard selectedAxisIndex > -1 else {return}
            axesNames[selectedAxisIndex] = newValue
        }
    }
    
    @objc var selectedAxisDefaultValue: Double {
        get {
            guard selectedAxisIndex > -1 else {return 0}
            return sliders.axes[selectedAxisIndex].default
        }
        set {
            var newDefault =  newValue
            switch newDefault {
            case let x where x < sliders.axes[selectedAxisIndex].bounds.lowerBound :
                newDefault = sliders.axes[selectedAxisIndex].bounds.lowerBound
            case let x where x > sliders.axes[selectedAxisIndex].bounds.upperBound :
                newDefault = sliders.axes[selectedAxisIndex].bounds.lowerBound
            default:
                break
            }
            sliders.axes[selectedAxisIndex].default = newDefault
        }
    }
    
    @objc var selectedAxisLowerBound: Double {
        get {
            guard selectedAxisIndex > -1 else {return 0}
            return sliders.axes[selectedAxisIndex].bounds.lowerBound
        }
        set {
            let upperBound = sliders.axes[selectedAxisIndex].bounds.upperBound
            let lowerBound = newValue
            guard lowerBound < upperBound else {return}
            sliders.axes[selectedAxisIndex].bounds = lowerBound...upperBound
        }
    }
    
    
    @objc var selectedAxisUpperBound: Double {
        get {
            guard selectedAxisIndex > -1 else {return 0}
            return sliders.axes[selectedAxisIndex].bounds.upperBound
        }
        set {
            let upperBound = newValue
            let lowerBound = sliders.axes[selectedAxisIndex].bounds.lowerBound
            guard lowerBound < upperBound else {return}
            sliders.axes[selectedAxisIndex].bounds = lowerBound...upperBound
        }
    }
    
    @objc var selectedAxesIndexes:IndexSet {
        get {
            
            return [selectedAxisIndex]
            
        }
        set {  //TODO tu jest coś żle chyba
            willChangeValue(for: \IGSlidersController.selectedStylesIndexes)
            
            //print ("CONTROLLER ••• set selectedAxesIndexes", Array(newValue))
            selectedAxisIndex = newValue.first ?? -1
            didChangeValue(for: \IGSlidersController.selectedStylesIndexes)
        }
    }
    
}
