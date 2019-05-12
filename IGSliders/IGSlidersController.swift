//
//  IGSlidersController.swift
//  IGSliders
//
//  Created by Łukasz Dziedzic on 30/04/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit


public class IGSlidersController: NSViewController {
    
    @IBOutlet public weak var sliders: IGSlidersView!
    
    init () {
        super.init(nibName: "IGEditView", bundle: Bundle.init(identifier: "com.typoland.IGSliders"))
    }
    
    required init?(coder: NSCoder) {
        super.init(nibName: "IGEditView", bundle: Bundle.init(identifier: "com.typoland.IGSliders"))    }
    
    
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
        return sliders != nil
    }
    
    @objc var canAddStyle: Bool {
        return selectedAxisIndex >= 0
    }
    
    @objc var canRemoveAxis: Bool {
        return selectedAxisIndex >= 0
    }
    
    @objc var canRemoveStyle: Bool {
        return sliders.selectedStyleIndex >= 0
    }
    
    @objc var selectedAxisStylesNames: [String] {
        get {
            print ("CONTROLLER getting styles names")
            return sliders.selectedAxisStyleNames
        }
        set {
            print ("CONTROLLER setting Style names")
        }
    }
    
    @objc var axesNamesString: String {
        var s = axesNames.reduce("",  {str, name in
            return "\(str) \(name.count == 0 ? "<no name>" : name),"
        })
        if !s.isEmpty { _ = s.removeLast() }
        return s
    }
    
    @objc var selectedAxisStylesNamesString: String {
        var s = selectedAxisStylesNames.reduce("",  {str, name in
            return "\(str) \(name.count == 0 ? "<no name>" : name),"
        })
        if !s.isEmpty { _ = s.removeLast() }
        return s
    }
    
    @objc var selectedAxisIndex: Int {
        get {
            return sliders.selectedAxisIndex
        }
        set {
            willChangeValue(for: \IGSlidersController.canAddAxis)
            willChangeValue(for: \IGSlidersController.canRemoveAxis)
            willChangeValue(for: \IGSlidersController.canAddStyle)
            willChangeValue(for: \IGSlidersController.canRemoveStyle)
            willChangeValue(for: \IGSlidersController.selectedStyleIndex)
            willChangeValue(for: \IGSlidersController.selectedAxesIndexes)
            willChangeValue(for: \IGSlidersController.selectedStylesIndexes)
            willChangeValue(for: \IGSlidersController.selectedStyleName)
            willChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
            willChangeValue(for: \IGSlidersController.selectedAxisDefaultValue)
            willChangeValue(for: \IGSlidersController.selectedAxisLowerBound)
            willChangeValue(for: \IGSlidersController.selectedAxisUpperBound)
            willChangeValue(for: \IGSlidersController.selectedAxisName)
        
            sliders.selectedAxisIndex = newValue
            saveToDefaults(self)
            
            didChangeValue(for: \IGSlidersController.selectedAxisName)
            didChangeValue(for: \IGSlidersController.selectedAxisUpperBound)
            didChangeValue(for: \IGSlidersController.selectedAxisLowerBound)
            didChangeValue(for: \IGSlidersController.selectedAxisDefaultValue)
            didChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
            didChangeValue(for: \IGSlidersController.selectedStyleName)
            didChangeValue(for: \IGSlidersController.selectedStylesIndexes)
            didChangeValue(for: \IGSlidersController.selectedAxesIndexes)
            didChangeValue(for: \IGSlidersController.selectedStyleIndex)
            didChangeValue(for: \IGSlidersController.canAddStyle)
            didChangeValue(for: \IGSlidersController.canRemoveStyle)
            didChangeValue(for: \IGSlidersController.canRemoveAxis)
            didChangeValue(for: \IGSlidersController.canAddAxis)

            
        }
    }
    
    @objc var selectedAxisName: String {
        get {
            guard selectedAxisIndex > -1 else {return ""}
            return axesNames[selectedAxisIndex]
        }
        set {
            axesNames[selectedAxisIndex] = newValue
        }
    }
    
    @objc var selectedStyleName: String {
        get {
            guard selectedStyleIndex > -1 else {return ""}
            return sliders.axes[selectedAxisIndex].styles[selectedStyleIndex].name
        }
        set {
            willChangeValue(for: \IGSlidersController.selectedStyleName)
            willChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
            guard selectedStyleIndex > -1 else {return} //nie wiem
            sliders.axes[selectedAxisIndex].styles[selectedStyleIndex].name = newValue
            didChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
            didChangeValue(for: \IGSlidersController.selectedStyleName)
        }
    }
    
    
    
    @objc var selectedStyleIndex: Int {
        
        get {
            return sliders.selectedStyleIndex
        }
        set {
            willChangeValue(for: \IGSlidersController.selectedStyleName)
            willChangeValue(for: \IGSlidersController.canAddStyle)
            willChangeValue(for: \IGSlidersController.canRemoveStyle)
            print ("set selectedStyleIndex to \(selectedStyleIndex)")
            sliders.selectedStyleIndex = newValue
            didChangeValue(for: \IGSlidersController.canRemoveStyle)
            didChangeValue(for: \IGSlidersController.canAddStyle)
            didChangeValue(for: \IGSlidersController.selectedStyleName)
            
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

            print ("CONTROLLER ••• set selectedAxesIndexes", Array(newValue))
            selectedAxisIndex = newValue.first ?? -1
            didChangeValue(for: \IGSlidersController.selectedStylesIndexes)
        }
    }
    
    @objc var selectedStylesIndexes: IndexSet {
        get {
            return [sliders.selectedStyleIndex]
        }
        set { //TODO tu jest coś żle chyba
            print ("CONTROLLER ••• set Styles indexes", Array(newValue))
            selectedStyleIndex = newValue.first ?? -1
        }
    }
    
    
    
    @IBAction func addAxis(_ sender:Any) {
        willChangeValue(for: \IGSlidersController.axesNames)
        willChangeValue(for: \IGSlidersController.selectedAxisIndex)
        willChangeValue(for: \IGSlidersController.selectedStyleIndex)
        sliders.addAxis()
        selectedAxisIndex = sliders.selectedAxisIndex
        selectedStyleIndex = -1
        didChangeValue(for: \IGSlidersController.selectedStyleIndex)
        didChangeValue(for: \IGSlidersController.selectedAxisIndex)
        didChangeValue(for: \IGSlidersController.axesNames)
    }

    @IBAction func addStyle(_ sender:Any) {
        willChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
        willChangeValue(for: \IGSlidersController.selectedStyleIndex)
        willChangeValue(for: \IGSlidersController.canRemoveStyle)
        sliders.addStyle()
        selectedStyleIndex = sliders.selectedStyleIndex
        didChangeValue(for: \IGSlidersController.canRemoveStyle)
        didChangeValue(for: \IGSlidersController.selectedStyleIndex)
        didChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
    }

    @IBAction func removeAxis(_ sender:Any) {
        willChangeValue(for: \IGSlidersController.axesNames)
        willChangeValue(for: \IGSlidersController.selectedAxisIndex)
        //let currentIndex = selectedAxisIndex
        sliders.removeAxis()
        selectedAxisIndex = sliders.axes.count > 0 ? 0 : -1
        didChangeValue(for: \IGSlidersController.selectedAxisIndex)
        didChangeValue(for: \IGSlidersController.axesNames)
    }
    
    @IBAction func removeStyle(_ sender:Any) {
        willChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
        willChangeValue(for: \IGSlidersController.selectedStyleName)
         willChangeValue(for: \IGSlidersController.selectedStyleIndex)
        sliders.removeStyle()
        didChangeValue(for: \IGSlidersController.selectedStyleName)
        didChangeValue(for: \IGSlidersController.selectedStyleIndex)
        didChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
    }

    
    @IBAction func changeAxisName(_ sender:Any) {
        guard let control  = sender as? NSControl else {return}
        print ("CONTROLLER change axis name \(control.stringValue)")
        willChangeValue(for: \IGSlidersController.axesNames)
        sliders?.changeCurrentAxis(control.stringValue)
        didChangeValue(for: \IGSlidersController.axesNames)
    }
    
    @IBAction func changeStyleName(_ sender:Any) {
        guard let control = sender as? NSControl else {return}
        print ("CONTROLLER change style name \(control.stringValue)")
        willChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
        sliders?.changeCurrentStyleName(control.stringValue)
        didChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
    }
    
    @IBAction func setSelectedAxis(_ sender:Any) {
        print ("\nCONTROLLER set selected Axis -> \(selectedAxisIndex)")
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
        print ("CONTROLLER -> set selected Axis \(selectedAxisIndex)\n")
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
            let max = sliders.selectedAxisStyleNames.count-1
            print ("•")
            selectedStyleIndex = nr > max ? max : nr
            print ("°", selectedStyleIndex, nr, max, nr>max)
        default: selectedStyleIndex = -1
        }
        print ("set selected Style \(selectedStyleIndex)")
    }
    
    
}
