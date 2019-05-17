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
    
       public override func viewDidLoad() {
    //        print ("did load")
    //        tableView.delegate = self
    //        tableView.dataSource = self
    //        guard let edgesController = edgeValuesController else {
    //            print ("nopr")
    //            return}
    //
//            selectedStyleValuesController.addObserver(self, forKeyPath: "selectedObjects", options: [.old, .new], context: nil)
//            print ("OK", selectedStyleValuesController.arrangedObjects)
       }
    
//       override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//            print ("something changed \(change), \(object)")
//        print ((object as? NSArrayController)?.arrangedObjects)
//      }
    
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
    
    var axisDuringDeletion = false
    var styleDuringDeletion = false

    private var _selectedAxisIndex: Int? = nil {
        willSet {
            guard let axisIndex = _selectedAxisIndex, !axisDuringDeletion else
            {
                return
            }
            let axis = sliders.axes[axisIndex]
            axis.selectedStyleIndex = selectedStyleIndex
            
        }
        
        didSet {
            guard let axisIndex = _selectedAxisIndex else {
                _selectedStyleIndex = nil
                return
            }
            
            //if let axis = currentAxis {
            _selectedStyleIndex = sliders.axes[axisIndex].selectedStyleIndex
            
            
            axisDuringDeletion = false
        }
    }
    
    @objc var selectedAxisIndex: Int {
        
        get {
            guard let index = _selectedAxisIndex else { return -1 }
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
            
            
            _selectedAxisIndex = newValue < 0 ? nil : newValue
            
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
    
    
    private var _selectedStyleIndex: Int? = nil {
        didSet {
            if let axis = currentAxis {
                axis.selectedStyleIndex = selectedStyleIndex
            } else {
                _selectedStyleIndex = nil
            }
            styleDuringDeletion = true
        }
    }
    
    @objc var selectedStyleIndex: Int {
        
        get {
            guard let index = _selectedStyleIndex else { return -1 }
            return index
        }
        set {
            willChangeValue(for: \IGSlidersController.selectedStyleName)
            willChangeValue(for: \IGSlidersController.canAddStyle)
            willChangeValue(for: \IGSlidersController.canRemoveStyle)
            willChangeValue(for: \IGSlidersController.selectedStyleValuesCount)
            willChangeValue(for: \IGSlidersController.currentStyleValues)
            
            _selectedStyleIndex = newValue < 0 ? nil : newValue
            
            didChangeValue(for: \IGSlidersController.currentStyleValues)
            didChangeValue(for: \IGSlidersController.canRemoveStyle)
            didChangeValue(for: \IGSlidersController.canAddStyle)
            didChangeValue(for: \IGSlidersController.selectedStyleName)
            didChangeValue(for: \IGSlidersController.selectedStyleValuesCount)
            //instances().forEach  { print ("•", $0)}
            
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
            object: (coordinates: instances, sliders:slidersCoordinates),
            userInfo: nil)
    }
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
