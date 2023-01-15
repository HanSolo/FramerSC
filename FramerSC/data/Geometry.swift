//
//  Geometry.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation


public struct Geometry : Codable {
    let type        : String
    let coordinates : [[[Double]]]
    
    
    enum CodingKeys: String, CodingKey {
        case type        = "type"
        case coordinates = "coordinates"
    }
}
