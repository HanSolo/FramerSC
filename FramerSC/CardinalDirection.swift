//
//  CardinalDirection.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation


public enum CardinalDirection: String, Equatable, CaseIterable {
    case N
    case NNE
    case NE
    case ENE
    case E
    case ESE
    case SE
    case SSE
    case S
    case SSW
    case SW
    case WSW
    case W
    case WNW
    case NW
    case NNW
    case NOT_FOUND
    
    var uiString: String {
        switch self {
            case .N         : return "North"
            case .NNE       : return "North North-East"
            case .NE        : return "North-East"
            case .ENE       : return "East North-East"
            case .E         : return "East"
            case .ESE       : return "East South-East"
            case .SE        : return "South-East"
            case .SSE       : return "South South-East"
            case .S         : return "South"
            case .SSW       : return "South South-West"
            case .SW        : return "South-West"
            case .WSW       : return "West South-West"
            case .W         : return "West"
            case .WNW       : return "West North-West"
            case .NW        : return "North-West"
            case .NNW       : return "North North-West"
            case .NOT_FOUND : return ""
        }
    }
    
    var apiString: String {
        switch self {
            case .N         : return "n"
            case .NNE       : return "nne"
            case .NE        : return "ne"
            case .ENE       : return "ene"
            case .E         : return "e"
            case .ESE       : return "ese"
            case .SE        : return "se"
            case .SSE       : return "sse"
            case .S         : return "s"
            case .SSW       : return "ssw"
            case .SW        : return "sw"
            case .WSW       : return "wsw"
            case .W         : return "w"
            case .WNW       : return "wnw"
            case .NW        : return "nw"
            case .NNW       : return "nnw"
            case .NOT_FOUND : return ""
        }
    }
    
    var id: Int64 {
        switch self {
            case .N         : return 0
            case .NNE       : return 1
            case .NE        : return 2
            case .ENE       : return 3
            case .E         : return 4
            case .ESE       : return 5
            case .SE        : return 6
            case .SSE       : return 7
            case .S         : return 8
            case .SSW       : return 9
            case .SW        : return 10
            case .WSW       : return 11
            case .W         : return 12
            case .WNW       : return 13
            case .NW        : return 14
            case .NNW       : return 15
            case .NOT_FOUND : return 16
        }
    }
    
    var fromTo: (Double, Double) {
        switch self {
            case .N         : return (348.75, 11.25)
            case .NNE       : return (11.25, 33.75)
            case .NE        : return (33.75, 56.25)
            case .ENE       : return (56.25, 78.75)
            case .E         : return (78.75, 101.25)
            case .ESE       : return (101.25, 123.75)
            case .SE        : return (123.75, 146.25)
            case .SSE       : return (146.25, 168.75)
            case .S         : return (168.75, 191.25)
            case .SSW       : return (191.25, 213.75)
            case .SW        : return (213.75, 236.25)
            case .WSW       : return (236.25, 258.75)
            case .W         : return (258.75, 281.25)
            case .WNW       : return (281.25, 303.75)
            case .NW        : return (303.75, 326.25)
            case .NNW       : return (326.25, 348.75)
            case .NOT_FOUND : return (0, 0)
        }
    }
    
    public static func fromText(text: String) -> CardinalDirection {
        switch text {
            case "n", "N"     : return CardinalDirection.N
            case "nne", "NNE" : return CardinalDirection.NNE
            case "ne", "NE"   : return CardinalDirection.NE
            case "ene", "ENE" : return CardinalDirection.ENE
            case "e", "E"     : return CardinalDirection.E
            case "ese", "ESE" : return CardinalDirection.ESE
            case "se", "SE"   : return CardinalDirection.SE
            case "sse", "SSE" : return CardinalDirection.SSE
            case "s", "S"     : return CardinalDirection.S
            case "ssw", "SSW" : return CardinalDirection.SSW
            case "sw", "SW"   : return CardinalDirection.SW
            case "wsw", "WSW" : return CardinalDirection.WSW
            case "w", "W"     : return CardinalDirection.W
            case "wnw", "WNW" : return CardinalDirection.WNW
            case "nw", "NW"   : return CardinalDirection.NW
            case "nnw", "NNW" : return CardinalDirection.NNW
            default           : return CardinalDirection.NOT_FOUND
        }
    }
}
