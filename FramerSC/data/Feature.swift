//
//  Feature.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation


public struct Feature : Codable {
    let type        : String
    let geometry    : Geometry
    let properties  : Properties
    
    
    enum CodingKeys: String, CodingKey {
        case type       = "type"
        case geometry   = "geometry"
        case properties = "properties"
    }
}
