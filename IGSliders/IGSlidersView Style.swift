//
//  IGSlidersView Style.swift
//  IGSliders
//
//  Created by Łukasz Dziedzic on 02/05/2019.
//  Copyright © 2019 Łukasz Dziedzic. All rights reserved.
//

import Foundation

extension IGSlidersView {
    
    struct Style: Codable {
        
        typealias CoordUnit = Double
        
        enum CodingKeys: String, CodingKey {
            case name
            case values
        }
        
        var name: String = "new Style"
        var axis: Axis? = nil
        var egdesValues: [CoordUnit] = []
        
        init () {
        }
        
        init(from decoder:Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decode(String.self, forKey: .name)
            egdesValues = try container.decode([CoordUnit].self, forKey: .values)
            self.axis = Axis()
            //super.init()
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(name, forKey: .name)
            try container.encode(egdesValues, forKey: .values)
        }
        
    }
}
