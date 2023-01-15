//
//  FovData.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation


public struct FovData : Codable {
    let camera_latitude      : Double
    let camera_longitude     : Double
    let subject_latitude     : Double
    let subject_longitude    : Double
    let sensor_format        : String
    let sensor_width         : Double
    let sensor_height        : Double
    let focal_length         : Int
    let aperture             : Double
    let orientation          : String
    let distance_to_subject  : Double
    let bearing              : Double
    let hyper_focal_distance : Double
    let fov_width            : Double
    let fov_height           : Double
    let fov_width_angle      : Double
    let fov_height_angle     : Double
    let dof_near_limit       : Double
    let dof_far_limit        : Double
    let dof_in_front         : Double
    let dof_behind           : Double
    let dof_total            : Double
    let max_subject_height   : Double
    let features             : [Feature]
    
    
    enum CodingKeys: String, CodingKey {
        case camera_latitude      = "camera_latitude"
        case camera_longitude     = "camera_longitude"
        case subject_latitude     = "subject_latitude"
        case subject_longitude    = "subject_longitude"
        case sensor_format        = "sensor_format"
        case sensor_width         = "sensor_width"
        case sensor_height        = "sensor_height"
        case focal_length         = "focal_length"
        case aperture             = "aperture"
        case orientation          = "orientation"
        case distance_to_subject  = "distance_to_subject"
        case bearing              = "bearing"
        case hyper_focal_distance = "hyper_focal_distance"
        case fov_width            = "fov_width"
        case fov_height           = "fov_height"
        case fov_width_angle      = "fov_width_angle"
        case fov_height_angle     = "fov_height_angle"
        case dof_near_limit       = "dof_near_limit"
        case dof_far_limit        = "dof_far_limit"
        case dof_in_front         = "dof_in_front"
        case dof_behind           = "dof_behind"
        case dof_total            = "dof_total"
        case max_subject_height   = "max_subject_height"
        case features
    }
    
    
    public func getOrientation() -> Orientation {
        return Orientation.fromText(text: self.orientation)
    }
    
    public func getFovTriangle() -> Triangle {
        let x1 = self.features[0].geometry.coordinates[0][0][0]
        let y1 = self.features[0].geometry.coordinates[0][0][1]
        let x2 = self.features[0].geometry.coordinates[0][1][0]
        let y2 = self.features[0].geometry.coordinates[0][1][1]
        let x3 = self.features[0].geometry.coordinates[0][2][0]
        let y3 = self.features[0].geometry.coordinates[0][2][1]
        return Triangle(x1: x1, y1: y1, x2: x2, y2: y2, x3: x3, y3: y3)
    }
    
    public func getDofTrapezoid() -> Trapezoid {
        let x1 = self.features[1].geometry.coordinates[0][0][0]
        let y1 = self.features[1].geometry.coordinates[0][0][1]
        let x2 = self.features[1].geometry.coordinates[0][1][0]
        let y2 = self.features[1].geometry.coordinates[0][1][1]
        let x3 = self.features[1].geometry.coordinates[0][2][0]
        let y3 = self.features[1].geometry.coordinates[0][2][1]
        let x4 = self.features[1].geometry.coordinates[0][3][0]
        let y4 = self.features[1].geometry.coordinates[0][3][1]
        return Trapezoid(x1: x1, y1: y1, x2: x2, y2: y2, x3: x3, y3: y3, x4: x4, y4: y4)
    }
}
