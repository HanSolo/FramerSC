//
//  ISO.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 21.01.23.
//

import Foundation


public enum ISO: String, Equatable, CaseIterable {
    case ISO_25
    case ISO_50
    case ISO_64
    case ISO_100
    case ISO_200
    case ISO_400
    case ISO_800
    case ISO_1600
    case ISO_3200
    case ISO_6400
    case ISO_12800
    case ISO_25600
    case ISO_51200
    case ISO_102400
    case ISO_204800
    case ISO_409600
    case NOT_FOUND
    
    
    var uiString: String {
        switch self {
        case .ISO_25     : return "ISO 25"
        case .ISO_50     : return "ISO 50"
        case .ISO_64     : return "ISO 64"
        case .ISO_100    : return "ISO 100"
        case .ISO_200    : return "ISO 200"
        case .ISO_400    : return "ISO 400"
        case .ISO_800    : return "ISO 800"
        case .ISO_1600   : return "ISO 1600"
        case .ISO_3200   : return "ISO 3200"
        case .ISO_6400   : return "ISO 6400"
        case .ISO_12800  : return "ISO 12800"
        case .ISO_25600  : return "ISO 25600"
        case .ISO_51200  : return "ISO 51200"
        case .ISO_102400 : return "ISO 102400"
        case .ISO_204800 : return "ISO 204800"
        case .ISO_409600 : return "ISO 409600"
        case .NOT_FOUND  : return ""
        }
    }
    
    var apiString: String {
        switch self {
        case .ISO_25     : return "iso_25"
        case .ISO_50     : return "iso_50"
        case .ISO_64     : return "iso_64"
        case .ISO_100    : return "iso_100"
        case .ISO_200    : return "iso_200"
        case .ISO_400    : return "iso_400"
        case .ISO_800    : return "iso_800"
        case .ISO_1600   : return "iso_1600"
        case .ISO_3200   : return "iso_3200"
        case .ISO_6400   : return "iso_6400"
        case .ISO_12800  : return "iso_12800"
        case .ISO_25600  : return "iso_25600"
        case .ISO_51200  : return "iso_51200"
        case .ISO_102400 : return "iso_102400"
        case .ISO_204800 : return "iso_204800"
        case .ISO_409600 : return "iso_409600"
        case .NOT_FOUND  : return ""
        }
    }
    
    var id: Double {
        switch self {
        case .ISO_25     : return 0
        case .ISO_50     : return 1
        case .ISO_64     : return 2
        case .ISO_100    : return 3
        case .ISO_200    : return 4
        case .ISO_400    : return 5
        case .ISO_800    : return 6
        case .ISO_1600   : return 7
        case .ISO_3200   : return 8
        case .ISO_6400   : return 9
        case .ISO_12800  : return 10
        case .ISO_25600  : return 11
        case .ISO_51200  : return 12
        case .ISO_102400 : return 13
        case .ISO_204800 : return 14
        case .ISO_409600 : return 15
        case .NOT_FOUND  : return 16
        }
    }
    
    var value: Int64 {
        switch self {
        case .ISO_25     : return 25
        case .ISO_50     : return 50
        case .ISO_64     : return 64
        case .ISO_100    : return 100
        case .ISO_200    : return 200
        case .ISO_400    : return 400
        case .ISO_800    : return 800
        case .ISO_1600   : return 1600
        case .ISO_3200   : return 3200
        case .ISO_6400   : return 6400
        case .ISO_12800  : return 12800
        case .ISO_25600  : return 25600
        case .ISO_51200  : return 51200
        case .ISO_102400 : return 102400
        case .ISO_204800 : return 204800
        case .ISO_409600 : return 409600
        case .NOT_FOUND  : return 0
        }
    }
        
    
    public static func fromText(text: String) -> ISO {
        switch text {
            case "iso_25", "ISO 25"         : return ISO_25
            case "iso_50", "ISO 50"         : return ISO_50
            case "iso_64", "ISO 64"         : return ISO_64
            case "iso_100", "ISO 100"       : return ISO_100
            case "iso_200", "ISO 200"       : return ISO_200
            case "iso_400", "ISO 400"       : return ISO_400
            case "iso_800", "ISO 800"       : return ISO_800
            case "iso_1600", "ISO 1600"     : return ISO_1600
            case "iso_3200", "ISO 3200"     : return ISO_3200
            case "iso_6400", "ISO 6400"     : return ISO_6400
            case "iso_12800", "ISO 12800"   : return ISO_12800
            case "iso_25600", "ISO 25600"   : return ISO_25600
            case "iso_51200", "ISO 51200"   : return ISO_51200
            case "iso_102400", "ISO 102400" : return ISO_102400
            case "iso_204800", "ISO 204800" : return ISO_204800
            case "iso_409600", "ISO 409600" : return ISO_409600
            default                         : return NOT_FOUND
        }
    }
}
