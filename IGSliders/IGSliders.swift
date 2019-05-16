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
    
    var axisDuringDeletion = false
    var styleDuringDeletion = false
    
    public var selectedAxisIndex: Int? = nil {
        willSet {
            guard let axisIndex = selectedAxisIndex, !axisDuringDeletion else
            {
                return
            }
            let axis = axes[axisIndex]
            axis.selectedStyleIndex = selectedStyleIndex
            
        }
        
        didSet {
            guard let axisIndex = selectedAxisIndex else {
                selectedStyleIndex = nil
                return
            }
            
            //if let axis = currentAxis {
            selectedStyleIndex = axes[axisIndex].selectedStyleIndex
            
        
            axisDuringDeletion = false
        }
    }
    
    public var selectedStyleIndex: Int? = nil {
        didSet {
            if let axis = currentAxis {
                axis.selectedStyleIndex = selectedStyleIndex
            } else {
                selectedStyleIndex = nil
            }
        }
    }
    
    
    var isAxisSelected: Bool {
        //return (0..<axes.count).contains(selectedAxisIndex) && axes.count > 0
        return selectedAxisIndex != nil && axes.count > 0
    }
    
    var currentAxis:Axis? {
        guard let axisIndex = selectedAxisIndex else { return nil }
        return axes [ axisIndex ]
    }
    
    var currentStyle:Style? {
        guard let styleIndex = selectedStyleIndex else { return nil }
        return currentAxis?.styles[styleIndex]
    }
    
    var isStyleSelected: Bool {
        guard let axis = currentAxis else  {return false}
        return axis.selectedStyleIndex != nil
        //return (0...axis.styles.count).contains(axis.selectedStyleIndex)
     
    }
    

    
    public var selectedAxisStyleNames:[String]  {
        get {
            guard let axis = currentAxis else { return [] }
            return axis.styles.map{$0.name == ""
                    ? axis.defaultStyleName
                    : $0.name }
        }
        set {
            guard let axis = currentAxis else { return }
            let count = newValue.count
            for index in 0..<count {
                axis.styles[index].name = newValue[index]
            }
        }
    }
    
    
    
    
    func addAxis() {
        print ("sliders Addidng Axis")

        axes.append(Axis())
        selectedAxisIndex = axes.count - 1
        for axisNr in 0 ..< axes.count {
            for styleNr in 0..<axes[axisNr].styles.count {
                
                let values = axes[axisNr].styles[styleNr].egdesValues
                axes[axisNr].styles[styleNr].egdesValues = values + values
                
            }
        }
        
    }
    
    func removeAxis() {
        guard let axisIndex = selectedAxisIndex else {return}
        axes.remove(at: axisIndex)
        axes.forEach { axis in
            axis.styles.forEach { style in
                let ev = style.egdesValues
                style.egdesValues = Array(ev[0..<ev.count/2])
            }
        }
        
        axisDuringDeletion = true
        selectedAxisIndex = axes.count == 0
            ? nil
            : axes.count == 0
            ? 0
            : axisIndex - 1

        
    }
    
    func addStyle() {
        guard let axis = currentAxis else {return}
        let newStyle = Style()
        let defaultValue = axis.default
        //TO DO recalculate default value to 0...1
        newStyle.egdesValues = Array(
            repeating: defaultValue,
            count: 1 << (axes.count - 1))
        axis.styles.append(newStyle)
        selectedStyleIndex = axis.styles.count - 1 > 0
            ? axis.styles.count - 1
            : nil
        
    }
    
    func removeStyle() {
        guard let axis = currentAxis, let styleIndex = selectedStyleIndex else {return}
        styleDuringDeletion = true
        
        axis.styles.remove(at: styleIndex)
        selectedStyleIndex = axis.styles.count == 0
            ? nil
            : axis.styles.count == 0
            ? 0
            : styleIndex - 1
    }
    
    func changeCurrentAxisName(_ name: String) {
        guard let axis = currentAxis else {return}
        axis.name = name
    }
    
    func changeCurrentStyleName(_ name: String) {
        guard let style = currentStyle else {return}
        style.name = name
    }
}
