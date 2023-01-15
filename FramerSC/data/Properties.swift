//
//  Properties.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation


public struct Properties : Codable {
    let name : String
    
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}
