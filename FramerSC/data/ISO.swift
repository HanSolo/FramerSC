//
//  ISO.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 21.01.23.
//

import Foundation


public struct ISO : Codable, Hashable {
    let uiString  : String
    let apiString : String
    let value     : Int
    
    
    enum CodingKeys: String, CodingKey {
        case uiString  = "ui_string"
        case apiString = "api_string"
        case value     = "value"
    }
}
