//
//  IGSlidersController + Style.swift
//  IGSliders
//
//  Created by Łukasz Dziedzic on 16/05/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

extension IGSlidersController {
    @objc var canAddStyle: Bool {
        return selectedAxisIndex >= 0
    }

    @IBAction func addStyle(_ sender:Any) {
        guard let axis = currentAxis else {return}
        willChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
        willChangeValue(for: \IGSlidersController.selectedStyleIndex)
        willChangeValue(for: \IGSlidersController.canRemoveStyle)
        
        sliders.addStyle(to: axis)
        selectedStyleIndex = axis.styles.count - 1
        didChangeValue(for: \IGSlidersController.canRemoveStyle)
        didChangeValue(for: \IGSlidersController.selectedStyleIndex)
        didChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
        notifyStylesChange()
    }
    
    @objc var canRemoveStyle: Bool {
        return selectedStyleIndex >= 0
    }
    
    @IBAction func removeStyle(_ sender:Any) {
        guard let axis = currentAxis, selectedStyleIndex >= 0 else {return}
        styleDuringDeletion = true
        willChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
        willChangeValue(for: \IGSlidersController.selectedStyleName)
        willChangeValue(for: \IGSlidersController.selectedStyleIndex)
        willChangeValue(for: \IGSlidersController.canRemoveStyle)
        sliders.removeStyle(from: axis, style: selectedStyleIndex)
        selectedStyleIndex = axis.styles.count == 1
            ? 0
            : selectedStyleIndex - 1
        didChangeValue(for: \IGSlidersController.selectedStyleName)
        didChangeValue(for: \IGSlidersController.selectedStyleIndex)
        didChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
        didChangeValue(for: \IGSlidersController.canRemoveStyle)
        notifyStylesChange()
    }
    
    @IBAction func setSelectedStyle(_ sender:Any) {
        
        switch sender {
        case is NSTableView:
            selectedStyleIndex = (sender as? NSTableView)?.selectedRow ?? -1
        case is Int:
            selectedStyleIndex = (sender as? Int) ?? -1
        case is NSControl:
            let nr = Int((sender as? NSControl)?.intValue ?? -1)
            print (nr)
            let max = selectedAxisStylesNames.count-1
            print ("•")
            selectedStyleIndex = nr > max ? max : nr
            print ("°", selectedStyleIndex, nr, max, nr>max)
        default: selectedStyleIndex = -1
        }
        print ("set selected Style \(selectedStyleIndex)")
    }
    
    var currentStyle: IGSliders.Style? {
        guard selectedStyleIndex >= 0 else { return nil }
        return currentAxis?.styles [selectedStyleIndex]
    }
    
    @IBAction func changeStyleName(_ sender:Any) {
        guard let control = sender as? NSControl,
            let style = currentStyle else {return}
        willChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
        style.name = control.stringValue
        didChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
    }
    
    @objc var selectedAxisStylesNames: [String] {
        get {
            guard let axis = currentAxis else { return [] }
            return axis.styles.map{$0.name == ""
                ? axis.defaultStyleName
                : $0.name }
        }
        
        set {
            guard let axis = currentAxis else { return }
            willChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
            willChangeValue(for: \IGSlidersController.selectedAxisName)
            
            
            let count = newValue.count
            for index in 0..<count {
                axis.styles[index].name = newValue[index]
            }
            
            didChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
            didChangeValue(for: \IGSlidersController.selectedAxisName)
        }
    }
    
    @objc var selectedAxisStylesNamesString: String {
        var s = selectedAxisStylesNames.reduce(into: "",  {$0 +=  " \($1),"})
        if !s.isEmpty { _ = s.removeLast() }
        return s
    }
    
    @objc var selectedStyleName: String {
        get {
            guard selectedStyleIndex > -1 else {return ""}
            return sliders.axes[selectedAxisIndex].styles[selectedStyleIndex].name
        }
        set {
            guard selectedStyleIndex > -1 else {return} //nie wiem
            willChangeValue(for: \IGSlidersController.selectedStyleName)
            willChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
            sliders.axes[selectedAxisIndex].styles[selectedStyleIndex].name = newValue
            didChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
            didChangeValue(for: \IGSlidersController.selectedStyleName)
        }
    }
    
    @objc var selectedStylesIndexes: IndexSet {
        get {
            guard  selectedStyleIndex >= 0 else { return [] }
            return [selectedStyleIndex]
        }
        set { //TODO tu jest coś żle chyba
            //print ("CONTROLLER ••• set Styles indexes", Array(newValue))
            guard let first = newValue.first else {
                selectedStyleIndex = -1
                return
            }
            selectedStyleIndex = first
            //selectedStyleIndex = newValue.first ?? -1
        }
    }
}
