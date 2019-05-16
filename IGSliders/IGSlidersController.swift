//
//  IGSlidersController.swift
//  IGSliders
//
//  Created by Łukasz Dziedzic on 30/04/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation
import AppKit

public extension Notification.Name {
//    static var IGSlidersControllerAxesChanged = NSNotification.Name(rawValue: "IGSlidersControllerAxesChanged")
    static var IGSlidersControllerStylesChanged = NSNotification.Name(rawValue: "IGSlidersControllerStylesChanged")
}

public class IGSlidersController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet public weak var slidersView: IGSlidersView!
    @IBOutlet public weak var selectedStyleValuesController: NSArrayController!
    
    var sliders: IGSliders = IGSliders()
    
    init () {
        super.init (nibName: "IGEditView", bundle: Bundle.init(identifier: "com.typoland.IGSliders"))
    }
    
    required init? (coder: NSCoder) {
        super.init(nibName: "IGEditView", bundle: Bundle.init(identifier: "com.typoland.IGSliders"))    }
    
//    public override func viewDidLoad() {
//        print ("did load")
//        tableView.delegate = self
//        tableView.dataSource = self
//        guard let edgesController = edgeValuesController else {
//            print ("nopr")
//            return}
//
//        edgesController.addObserver(self, forKeyPath: "selectedObjects", options: [.old, .new], context: nil)
//        print ("OK")
//    }

//    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        print ("something changed \(change), \(object)")
//    }

//    public func tableViewSelectionDidChange(_ notification:Notification) {
//        print ("change \(notification.object)")
//    }
//
//    public func numberOfRows(in tableView: NSTableView) -> Int {
//        print ("getting number of rows \(currentStyleValues.count)")
//        return currentStyleValues.count
//    }
    
//    public func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
//        print ("getting rows \(row)")
//        return currentStyleValues[row]
//    }
    //tableView:objectValueForTableColumn:row:
    
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
    
    @objc var canAddStyle: Bool {
        return selectedAxisIndex  >= 0
    }

    @objc var canRemoveAxis: Bool {
        return selectedAxisIndex >= 0
    }

    @objc var canRemoveStyle: Bool {
        return sliders.selectedStyleIndex != nil
    }

    class Nr:NSObject {
        @objc dynamic var value: Double = 0
        init (_ value:Double) {
            self.value = value
        }
    }

    @objc dynamic var currentStyleValues: [NSNumber] {
        get {
            guard let values = sliders.currentStyle?.egdesValues else {
                return []
            }
            return values.map {NSNumber(value: $0)}
        }
        set {
            print ("setting currentStyleValues", sliders.currentStyle, sliders.currentStyle?.egdesValues, newValue )
            guard let style = sliders.currentStyle else {return}
            print (newValue)
            style.egdesValues = newValue.map {$0.doubleValue}
        }
    }

    @objc var selectedAxisStylesNames: [String] {
        get {
            return sliders.selectedAxisStyleNames
        }
        set {
            willChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
            willChangeValue(for: \IGSlidersController.selectedAxisName)
            sliders.selectedAxisStyleNames = newValue
            didChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
            didChangeValue(for: \IGSlidersController.selectedAxisName)
        }
    }
    
    @objc var selectedStyleValuesCount:Int {
        guard selectedAxisIndex > -1, selectedStyleIndex > -1 else {return -1}
        return sliders.axes[selectedAxisIndex].styles[selectedStyleIndex].egdesValues.count
    }
    
    @objc var axesNamesString: String {
        var s = axesNames.reduce(into: "",  {str, name in
            str += " \(name.count == 0 ? "<Unnamed>" : name),"
        })
        if !s.isEmpty { _ = s.removeLast() }
        return s
    }
    
    @objc var selectedAxisStylesNamesString: String {
        var s = selectedAxisStylesNames.reduce(into: "",  {$0 +=  " \($1),"})
        if !s.isEmpty { _ = s.removeLast() }
        return s
    }
    
    @objc var selectedAxisIndex: Int {
        
        get {
            guard let index = sliders.selectedAxisIndex else { return -1 }
            return index
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
            willChangeValue(for: \IGSlidersController.currentStyleValues)

        
            sliders.selectedAxisIndex = newValue < 0 ? nil : newValue
            
            didChangeValue(for: \IGSlidersController.currentStyleValues)
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
            
            saveToDefaults(self)
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
            guard let index = sliders.selectedStyleIndex else { return -1 }
            return index
        }
        set {
            willChangeValue(for: \IGSlidersController.selectedStyleName)
            willChangeValue(for: \IGSlidersController.canAddStyle)
            willChangeValue(for: \IGSlidersController.canRemoveStyle)
            willChangeValue(for: \IGSlidersController.selectedStyleValuesCount)
            willChangeValue(for: \IGSlidersController.currentStyleValues)
            
            sliders.selectedStyleIndex = newValue < 0 ? nil : newValue
            
            didChangeValue(for: \IGSlidersController.currentStyleValues)

            didChangeValue(for: \IGSlidersController.canRemoveStyle)
            didChangeValue(for: \IGSlidersController.canAddStyle)
            didChangeValue(for: \IGSlidersController.selectedStyleName)
            didChangeValue(for: \IGSlidersController.selectedStyleValuesCount)
            //coordinates().forEach  { print ("•", $0)}
            
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
    
    @objc var selectedStylesIndexes: IndexSet {
        get {
            guard let styleIndex = sliders.selectedStyleIndex else { return [] }
            return [styleIndex]
        }
        set { //TODO tu jest coś żle chyba
            //print ("CONTROLLER ••• set Styles indexes", Array(newValue))
            sliders.selectedStyleIndex = newValue.first
            //selectedStyleIndex = newValue.first ?? -1
        }
    }
    
//    func notifyAxesChange() {
//        NotificationCenter.default.post(
//            name: Notification.Name.IGSlidersControllerAxesChanged,
//            object: coordinates(),
//            userInfo: nil)
//    }
    
    func notifyStylesChange() {
        NotificationCenter.default.post(
            name: Notification.Name.IGSlidersControllerStylesChanged,
            object: coordinates(),
            userInfo: nil)
    }
    
    @IBAction func addAxis(_ sender:Any) {
        willChangeValue(for: \IGSlidersController.axesNames)
        willChangeValue(for: \IGSlidersController.selectedAxisIndex)
        willChangeValue(for: \IGSlidersController.selectedStyleIndex)
        sliders.addAxis()
        //selectedAxisIndex = sliders.selectedAxisIndex
        selectedStyleIndex = -1
        didChangeValue(for: \IGSlidersController.selectedStyleIndex)
        didChangeValue(for: \IGSlidersController.selectedAxisIndex)
        didChangeValue(for: \IGSlidersController.axesNames)
        notifyStylesChange()
    }

    @IBAction func addStyle(_ sender:Any) {
        willChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
        willChangeValue(for: \IGSlidersController.selectedStyleIndex)
        willChangeValue(for: \IGSlidersController.canRemoveStyle)
        sliders.addStyle()
        //selectedStyleIndex = sliders.selectedStyleIndex
        didChangeValue(for: \IGSlidersController.canRemoveStyle)
        didChangeValue(for: \IGSlidersController.selectedStyleIndex)
        didChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
        notifyStylesChange()
    }

    @IBAction func removeAxis(_ sender:Any) {
        willChangeValue(for: \IGSlidersController.axesNames)
        willChangeValue(for: \IGSlidersController.selectedAxisIndex)
        //let currentIndex = selectedAxisIndex
        sliders.removeAxis()
        selectedAxisIndex = sliders.axes.count > 0 ? 0 : -1
        didChangeValue(for: \IGSlidersController.selectedAxisIndex)
        didChangeValue(for: \IGSlidersController.axesNames)
        notifyStylesChange()
    }
    
    @IBAction func removeStyle(_ sender:Any) {
        willChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
        willChangeValue(for: \IGSlidersController.selectedStyleName)
         willChangeValue(for: \IGSlidersController.selectedStyleIndex)
        willChangeValue(for: \IGSlidersController.canRemoveStyle)
        sliders.removeStyle()
        didChangeValue(for: \IGSlidersController.selectedStyleName)
        didChangeValue(for: \IGSlidersController.selectedStyleIndex)
        didChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
        didChangeValue(for: \IGSlidersController.canRemoveStyle)
        notifyStylesChange()
    }

    
    @IBAction func changeAxisName(_ sender:Any) {
        guard let control  = sender as? NSControl else {return}
        //print ("CONTROLLER change axis name \(control.stringValue)")
        willChangeValue(for: \IGSlidersController.axesNames)
        sliders.changeCurrentAxisName(control.stringValue)
        didChangeValue(for: \IGSlidersController.axesNames)
    }
    
    @IBAction func changeStyleName(_ sender:Any) {
        guard let control = sender as? NSControl else {return}
        //print ("CONTROLLER change style name \(control.stringValue)")
        willChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
        sliders.changeCurrentStyleName(control.stringValue)
        didChangeValue(for: \IGSlidersController.selectedAxisStylesNames)
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
        //print ("CONTROLLER -> set selected Axis \(selectedAxisIndex)\n")
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
