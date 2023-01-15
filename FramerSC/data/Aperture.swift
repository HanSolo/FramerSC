//
//  Aperture.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation


public struct Aperture : Codable, Hashable {
    let uiString       : String
    let apiString      : String
    let aperture       : Double
    let apertureTc_1_4 : Double
    let apertureTc_2_0 : Double
    
    
    enum CodingKeys: String, CodingKey {
        case uiString       = "ui_string"
        case apiString      = "api_string"
        case aperture       = "aperture"
        case apertureTc_1_4 = "aperture_tc_1_4"
        case apertureTc_2_0 = "aperture_tc_2_0"
    }
}
