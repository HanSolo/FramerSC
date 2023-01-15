//
//  Trapezoid.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation
import MapKit


public class Trapezoid {
    var x1      : Double
    var y1      : Double
    var x2      : Double
    var y2      : Double
    var x3      : Double
    var y3      : Double
    var x4      : Double
    var y4      : Double
    var polygon : MKPolygon
    
    
    init(x1: Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double, x4: Double, y4: Double) {
        self.x1      = x1
        self.y1      = y1
        self.x2      = x2
        self.y2      = y2
        self.x3      = x3
        self.y3      = y3
        self.x4      = x4
        self.y4      = y4
        self.polygon = MKPolygon(points: [MKMapPoint(x: x1, y: y1), MKMapPoint(x: x2, y: y2), MKMapPoint(x: x3, y: y3)], count: 3)
    }
    convenience init() {
        self.init(x1: 0, y1: 0, x2: 0, y2: 0, x3: 0, y3: 0, x4: 0, y4: 0)
    }
    convenience init(points : [Double]) throws {
        if points.count != 8 { throw IllegalArgumentError.runtimeError("Make sure to pass 8 numbers for the trapezoid") }
        self.init(x1: points[0], y1: points[1], x2: points[3], y2: points[4], x3: points[5], y3: points[5], x4: points[6], y4: points[7])
    }
    
    
    
    public func getPoints() -> [[Double]] {
        return [[x1, y1], [x2, y2], [x3, y3], [x4, y4]]
    }
    
    public func getCoordinates() -> [CLLocationCoordinate2D] {
        let p1 = CLLocationCoordinate2D(latitude: x1, longitude: y1)
        let p2 = CLLocationCoordinate2D(latitude: x2, longitude: y2)
        let p3 = CLLocationCoordinate2D(latitude: x3, longitude: y3)
        let p4 = CLLocationCoordinate2D(latitude: x4, longitude: y4)
        return [p1, p2, p3, p4]
    }
    
    public func getPolygon() -> MKPolygon {
        return MKPolygon(coordinates: getCoordinates(), count: 4)
    }
    
    public func toString() -> String {
        var msg : String = ""
        msg += "\(Constants.CURLY_BRACKET_OPEN)"
        msg += "\(Constants.QUOTES)type\(Constants.QUOTES_COLON)\(Constants.QUOTES)Feature\(Constants.QUOTES)\(Constants.COMMA)"
        msg += "\(Constants.QUOTES)geometry\(Constants.QUOTES_COLON)\(Constants.CURLY_BRACKET_OPEN)"
        msg += "\(Constants.QUOTES)type\(Constants.QUOTES_COLON)\(Constants.QUOTES)Polygon\(Constants.QUOTES)\(Constants.COMMA)"
        msg += "\(Constants.QUOTES)coordinates\(Constants.QUOTES_COLON)\(Constants.SQUARE_BRACKET_OPEN)"
        msg += "\(Constants.SQUARE_BRACKET_OPEN)"
        msg += "\(Constants.SQUARE_BRACKET_OPEN)\(x1)\(Constants.COMMA)\(y1)\(Constants.SQUARE_BRACKET_CLOSE)\(Constants.COMMA)"
        msg += "\(Constants.SQUARE_BRACKET_OPEN)\(x2)\(Constants.COMMA)\(y2)\(Constants.SQUARE_BRACKET_CLOSE)\(Constants.COMMA)"
        msg += "\(Constants.SQUARE_BRACKET_OPEN)\(x3)\(Constants.COMMA)\(y3)\(Constants.SQUARE_BRACKET_CLOSE)\(Constants.COMMA)"
        msg += "\(Constants.SQUARE_BRACKET_OPEN)\(x4)\(Constants.COMMA)\(y4)\(Constants.SQUARE_BRACKET_CLOSE)"
        msg += "\(Constants.SQUARE_BRACKET_CLOSE)"
        msg += "\(Constants.SQUARE_BRACKET_CLOSE)"
        msg += "\(Constants.CURLY_BRACKET_CLOSE)\(Constants.COMMA)"
        msg += "\(Constants.QUOTES)properties\(Constants.QUOTES_COLON)\(Constants.CURLY_BRACKET_OPEN)"
        msg += "\(Constants.QUOTES)name\(Constants.QUOTES_COLON)\(Constants.QUOTES)dofTrapezoid\(Constants.QUOTES)"
        msg += "\(Constants.CURLY_BRACKET_CLOSE)"
        msg += "\(Constants.CURLY_BRACKET_CLOSE)"
        return msg
    }
}
