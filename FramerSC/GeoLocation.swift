//
//  GeoLocation.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation
import CoreLocation


public class GeoLocation : Identifiable, Hashable, Equatable {
    public     let id        : UUID                   = UUID()
    @Published var key       : String                 = ""
    @Published var name      : String                 = ""
    @Published var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    
    init(key: String, name: String, latitude: Double, longitude: Double) {
        self.key        = key
        self.name       = name
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    convenience init(latitude: Double, longitude: Double) {
        self.init(key: "", name: "", latitude: latitude, longitude: longitude)
    }
    
        
    public func set(latitude: Double, longitude: Double) -> Void {
        self.coordinate.latitude  = latitude
        self.coordinate.longitude = longitude
    }
    
    public static func == (lhs: GeoLocation, rhs: GeoLocation) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
