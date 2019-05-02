//
//  IGSlidersController Axis.swift
//  IGSliders
//
//  Created by Łukasz Dziedzic on 02/05/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

extension IGSlidersView {
    struct Axis: Codable {
        
        typealias CoordUnit = Double
        
        enum CodingKeys: String, CodingKey {
            case name
            case lowerBound
            case upperBound
            case styles
        }
        var name: String = "new Axis"
        var bounds: ClosedRange<CoordUnit> = 0...1
        var `default`: CoordUnit = 0.5
        var styles:[Style] = []
        var selectedStyleIndex:Int = -1
        
        init() {
        }
        
        init(from decoder:Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            name = try container.decode(String.self, forKey: .name)
            let lb = try container.decode(CoordUnit.self, forKey: .lowerBound)
            let ub = try container.decode(CoordUnit.self, forKey: .upperBound)
            bounds = lb...ub
            styles = try container.decode([Style].self, forKey: .styles)
            //styles = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(stylesData) as? [ASVStyle] ?? []
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(name, forKey: .name)
            try container.encode(bounds.lowerBound, forKey: .lowerBound)
            try container.encode(bounds.upperBound, forKey: .upperBound)
            try container.encode(styles, forKey: .styles)
            //let stylesData = try NSKeyedArchiver.archivedData(withRootObject: styles, requiringSecureCoding: false)
            //try container.encode(stylesData, forKey: .styles)
            
        }
    }
}
