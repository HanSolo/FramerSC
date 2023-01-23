//
//  ShutterSpeed.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 23.01.23.
//

import Foundation


public struct ShutterSpeed : Codable, Hashable {
    let uiString  : String
    let apiString : String
    let value     : Double
    
    
    enum CodingKeys: String, CodingKey {
        case uiString  = "ui_string"
        case apiString = "api_string"
        case value     = "value"
    }
}
