//
//  IGSliders.swift
//  
//
//  Created by Łukasz Dziedzic on 29/04/2019.
//

import Foundation
import AppKit


public class IGSliders:NSView {
    
    typealias CoordUnit = Double
    
    struct Axis {
        var name: String = "new Axis"
        var bounds: ClosedRange<CoordUnit> = 0...1
        var `default`: CoordUnit = 0.5
        var styles:[Style] = []
        var selectedStyleIndex:Int = -1
    }
    
    struct Style {
        var name: String = "new Style"
        var axis: Axis? = nil
        var egdesValues: [CoordUnit] = []
    }
    
    var axes:[Axis] = []
    
    
    var isAxisSelected:Bool {
        return (0...axes.count).contains(selectedAxisIndex) && axes.count > 0
    }
    
    
    var isStyleSelected: Bool {
        if !isAxisSelected {return false}
        else {
            let axis = axes[selectedAxisIndex]
            return (0...axis.styles.count).contains(axis.selectedStyleIndex)
        }
    }
    
    @objc public var axesNames:[String]  {
        get {
            return axes.map {$0.name}
        }
        set {
            guard axes.count == newValue.count else {return}
            for index in 0...axes.count-1 {
                axes[index].name = newValue[index]
            }
        }
    }
    
    @objc public var selectedAxisStyleNames:[String]  {
        get {
            return isAxisSelected ?
                axes[selectedAxisIndex].styles.map{$0.name}
            :   []
        }
        set {
            if isAxisSelected {
                let count = axes[selectedAxisIndex].styles.count
                for index in 0...count-1 {
                    axes[selectedAxisIndex].styles[index].name = newValue[index]
                }
            }
        }
    }
    
    
    
    
    @objc public var selectedAxisIndex: Int = -1 {
        willSet {
            
            axes.forEach{print(" • <Axis> willSet", $0.name, $0.selectedStyleIndex)}
            if isAxisSelected {
                axes[selectedAxisIndex].selectedStyleIndex = selectedStyleIndex
            }
        }
        
        didSet {
            
            if isAxisSelected {
                selectedStyleIndex = axes[selectedAxisIndex].selectedStyleIndex
            } else {
                selectedStyleIndex = -1
            }
            print ("OH, axis index binded", isAxisSelected, selectedAxisIndex, selectedStyleIndex)
            axes.forEach{print(" • <Axis> didSet", $0.name, $0.selectedStyleIndex)}
        }
    }
    
    @objc public var selectedStyleIndex: Int = -1 {
        didSet {
            
//            axes.forEach{print("IN  >>", $0.name, $0.selectedStyleIndex)}
            if isAxisSelected {
                axes[selectedAxisIndex].selectedStyleIndex = selectedStyleIndex
            } //else {
//                selectedStyleIndex = -1
//            }
            print ("OH, style index is binded", selectedAxisIndex, selectedStyleIndex)
//            axes.forEach{print("OUT >>", $0.name, $0.selectedStyleIndex)}
        }
    }
    

    func addAxis() {
        print ("sliders Addidng Axis")
        let newAxis = Axis()
        axes.append(newAxis)
        selectedAxisIndex = axes.count - 1
    }
    
    func removeAxis() {
        guard isAxisSelected else {return}
        axes.remove(at: selectedAxisIndex)
        selectedAxisIndex = selectedAxisIndex > axes.count - 1 ?
            axes.count - 1 : selectedAxisIndex
    }
    
    func addStyle() {
        guard isAxisSelected else {return}
        let newStyle = Style()
        axes[selectedAxisIndex].styles.append(newStyle)
        
    }
    
    func removeStyle() {
        guard isStyleSelected else {return}
        axes[selectedAxisIndex].styles.remove(at: selectedStyleIndex)
    }
    
    func changeCurrentAxis(_ name: String) {
        guard isAxisSelected else {return}
        axes[selectedAxisIndex].name = name
    }
    
    func changeCurrentStyleName(_ name: String) {
        print ("isStyleSelected", isStyleSelected)
        guard isStyleSelected else {return}
        axes[selectedAxisIndex].styles[selectedStyleIndex].name = name
    }
}
