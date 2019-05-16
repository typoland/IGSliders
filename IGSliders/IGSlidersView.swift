//
//  IGSliders.swift
//  
//
//  Created by Łukasz Dziedzic on 29/04/2019.
//

import Foundation
import AppKit


public class IGSlidersView:NSView {
    
    typealias CoordUnit = Double
    
//    var axes:[Axis] = []
//
//    var isAxisSelected: Bool {
//        return (0..<axes.count).contains(selectedAxisIndex) && axes.count > 0
//    }
//
//    var isStyleSelected: Bool {
//        if !isAxisSelected {return false}
//        else {
//            let axis = axes[selectedAxisIndex]
//            return (0...axis.styles.count).contains(axis.selectedStyleIndex)
//        }
//    }
//
//
//    @objc public var selectedAxisStyleNames:[String]  {
//        get {
//            return isAxisSelected ?
//                axes[selectedAxisIndex].styles.map{$0.name == ""
//                    ? axes[selectedAxisIndex].defaultStyleName
//                    : $0.name }
//            :   []
//        }
//        set {
//            if isAxisSelected {
//                let count = axes[selectedAxisIndex].styles.count
//                for index in 0...count-1 {
//                    axes[selectedAxisIndex].styles[index].name = newValue[index]
//                }
//            }
//        }
//    }
//
//
//    var axisDuringDeletion = false
//    var styleDuringDeletion = false
//
//    @objc public var selectedAxisIndex: Int = -1 {
//        willSet {
//            //print (axes)
//            //axes.forEach{print(" • <Axis> willSet", $0.name, $0.selectedStyleIndex)}
//            guard isAxisSelected, !axisDuringDeletion  else { return }
//                axes[selectedAxisIndex].selectedStyleIndex = selectedStyleIndex
//
//        }
//
//        didSet {
//
//            if isAxisSelected {
//                selectedStyleIndex = axes[selectedAxisIndex].selectedStyleIndex
//            } else {
//                selectedStyleIndex = -1
//            }
//             //print (selectedAxisIndex)
//            //axes.forEach{print(" • <Axis> didSet ", $0.name, $0.selectedStyleIndex)}
//            axisDuringDeletion = false
//        }
//    }
//
//    @objc public var selectedStyleIndex: Int = -1 {
//        didSet {
//            if isAxisSelected {
//                axes[selectedAxisIndex].selectedStyleIndex = selectedStyleIndex
//            } else {
//                selectedStyleIndex = -1
//            }
//        }
//    }
//
//
//    func addAxis() {
//        print ("sliders Addidng Axis")
//        let newAxis = Axis()
//        axes.append(newAxis)
//        selectedAxisIndex = axes.count - 1
//        for axisNr in 0 ..< axes.count {
//            for styleNr in 0..<axes[axisNr].styles.count {
//
//                let values = axes[axisNr].styles[styleNr].egdesValues
//                axes[axisNr].styles[styleNr].egdesValues = values + values
//
//            }
//        }
//
//    }
//
//    func removeAxis() {
//        guard isAxisSelected else {return}
//        axes.remove(at: selectedAxisIndex)
//        (0..<axes.count).forEach { axisIndex in
//            (0..<axes[axisIndex].styles.count).forEach { styleIndex in
//                let ev = axes[axisIndex].styles[styleIndex].egdesValues
//                axes[axisIndex].styles[styleIndex].egdesValues = Array(ev[0..<ev.count/2])
//            }
//        }
//
//        axisDuringDeletion = true
//        selectedAxisIndex = selectedAxisIndex == 0 ? 0 : selectedAxisIndex - 1
//
//    }
//
//    func addStyle() {
//        guard isAxisSelected else {return}
//        var newStyle = Style()
//        let defaultValue = axes[selectedAxisIndex].default
//        newStyle.egdesValues = Array(
//            repeating: defaultValue,
//            count: 1 << (axes.count - 1))
//        axes[selectedAxisIndex].styles.append(newStyle)
//        selectedStyleIndex = axes[selectedAxisIndex].styles.count - 1
//
//    }
//
//    func removeStyle() {
//        guard isStyleSelected else {return}
//        styleDuringDeletion = true
//
//        axes[selectedAxisIndex].styles.remove(at: selectedStyleIndex)
//        selectedStyleIndex = axes[selectedAxisIndex].styles.count == 1 ?
//            0 : selectedStyleIndex - 1
//    }
//
//    func changeCurrentAxisName(_ name: String) {
//        guard isAxisSelected else {return}
//        axes[selectedAxisIndex].name = name
//    }
//
//    func changeCurrentStyleName(_ name: String) {
//        //print ("isStyleSelected", isStyleSelected)
//        guard isStyleSelected else {return}
//        axes[selectedAxisIndex].styles[selectedStyleIndex].name = name
//    }
}
