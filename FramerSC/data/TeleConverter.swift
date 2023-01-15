//
//  TeleConverter.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation


public struct TeleConverter : Codable, Hashable {
    let uiString  : String
    let apiString : String
    let factor    : Double
    
    
    enum CodingKeys: String, CodingKey {
        case uiString  = "ui_string"
        case apiString = "api_string"
        case factor    = "factor"
    }
}
