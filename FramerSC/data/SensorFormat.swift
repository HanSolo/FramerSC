//
//  SensorFormat.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation


public struct SensorFormat : Codable, Hashable {
    let uiString   : String
    let apiString  : String
    let width      : Double
    let height     : Double
    let cropFactor : Double
    
    
    enum CodingKeys: String, CodingKey {
        case uiString   = "ui_string"
        case apiString  = "api_string"
        case width      = "width"
        case height     = "height"
        case cropFactor = "crop_factor"
    }
}
