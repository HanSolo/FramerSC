//
//  Orientation.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation


public enum Orientation: String, Equatable, CaseIterable {
    case LANDSCAPE
    case PORTRAIT
    case NOT_FOUND
    
    
    var uiString: String {
        switch self {
            case .LANDSCAPE : return "Landscape"
            case .PORTRAIT  : return "Portrait"
            case .NOT_FOUND : return ""
        }
    }
    
    var apiString: String {
        switch self {
            case .LANDSCAPE : return "landscape"
            case .PORTRAIT  : return "portrait"
            case .NOT_FOUND : return ""
        }
    }
    
    var id: Int64 {
        switch self {
        case .LANDSCAPE : return 0
        case .PORTRAIT  : return 1
        case .NOT_FOUND : return 2
        }
    }
        
    public static func fromText(text: String) -> Orientation {
        switch text {
            case "landscape", "LANDSCAOE", "Landscape" : return Orientation.LANDSCAPE
            case "portrait", "PORTRAIT", "Portrait"    : return Orientation.PORTRAIT
            default                                    : return Orientation.NOT_FOUND
        }
    }
}
