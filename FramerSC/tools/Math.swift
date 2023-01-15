//
//  Math.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation


public struct Math {
    
    public static func toRadians(deg: Double) -> Double {
        return deg * .pi / 180
    }
    
    public static func toDegrees(rad: Double) -> Double {
        return rad * 180 / .pi
    }
}
