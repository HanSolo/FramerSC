//
//  EV.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 23.01.23.
//

import Foundation


public struct EV : Codable, Hashable {
    let uiString    : String
    let apiString   : String
    let description : String
    let value       : Int
    
    
    enum CodingKeys: String, CodingKey {
        case uiString    = "ui_string"
        case apiString   = "api_string"
        case description = "description"
        case value       = "value"
    }
}
