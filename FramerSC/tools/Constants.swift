//
//  Constants.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation
import SwiftUI


public struct Constants {
        
    // Host and endpoints information
    public static let PROTOCOL                : String = "http"
    public static let HOST                    : String = "hansolo.eu"
    public static let PORT                    : Int    = 8081
    public static let BASE_PATH               : String = "/framer/"
    public static let API_VERSION             : String = "v1.0"
    public static let CALC_FOV_ENDPOINT       : String = "/calc_fov"
    public static let CALC_TC_ENDPOINT        : String = "/calc_tc"
    public static let APERTURES_ENDPOINT      : String = "/apertures"
    public static let ISOS_ENDPOINT           : String = "/isos"
    public static let SENSORS_ENDPOINT        : String = "/sensors"
    public static let TELECONVERTERS_ENDPOINT : String = "/teleconverters"
    public static let CALC_FOV_PATH           : String = "\(BASE_PATH)\(API_VERSION)\(CALC_FOV_ENDPOINT)"
    public static let CALC_TC_PATH            : String = "\(BASE_PATH)\(API_VERSION)\(CALC_TC_ENDPOINT)"
    public static let APERTURES_PATH          : String = "\(BASE_PATH)\(API_VERSION)\(APERTURES_ENDPOINT)"
    public static let ISOS_PATH               : String = "\(BASE_PATH)\(API_VERSION)\(ISOS_ENDPOINT)"
    public static let SENSORS_PATH            : String = "\(BASE_PATH)\(API_VERSION)\(SENSORS_ENDPOINT)"
    public static let TELECONVERTERS_PATH     : String = "\(BASE_PATH)\(API_VERSION)\(TELECONVERTERS_ENDPOINT)"
    
    
    // Some standard strings for JSON output
    public static let SQUARE_BRACKET_OPEN     : String = "[";
    public static let SQUARE_BRACKET_CLOSE    : String = "]";
    public static let CURLY_BRACKET_OPEN      : String = "{"
    public static let CURLY_BRACKET_CLOSE     : String = "}"
    public static let INDENTED_QUOTES         : String = "  \"";
    public static let QUOTES_COLON            : String = "\":";
    public static let QUOTES                  : String = "\"";
    public static let COLON                   : String = ":";
    public static let COMMA                   : String = ",";
    public static let SLASH                   : String = "/";
    public static let NEW_LINE                : String = "\n";
    public static let COMMA_NEW_LINE          : String = ",\n";
    public static let INDENT                  : String = "  ";
    
    
    public static let INFINITE                : String = "Infinite"
    
    #if os(macOS)

    // Field of view overlay fill
    public static let FOV_TRIANGLE_FILL       : NSColor = NSColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 0.3)
    
    // Field of view overlay stroke
    public static let FOV_TRIANGLE_STROKE     : NSColor = NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.9)
    
    // Depth of field overlay fill
    public static let DOF_TRAPEZOID_FILL      : NSColor = NSColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.3)
    
    // Depth of field overlay stroke
    public static let DOF_TRAPEZOID_STROKE    : NSColor = NSColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.9)

    #elseif os(iOS)
    
    // Field of view overlay fill
    public static let FOV_TRIANGLE_FILL       : UIColor = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 0.3)
    
    // Field of view overlay stroke
    public static let FOV_TRIANGLE_STROKE     : UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.9)
    
    // Depth of field overlay fill
    public static let DOF_TRAPEZOID_FILL      : UIColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.3)
    
    // Depth of field overlay stroke
    public static let DOF_TRAPEZOID_STROKE    : UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.9)

    #endif
    
    public static let FETCHING_DATA_TEXT      : String = "Fetching data"
        
    // Minimum allowed focal length in [mm]
    public static let MIN_FOCAL_LENGTH        : Int    = 8;
    
    // Maximum allowed focal length in [mm]
    public static let MAX_FOCAL_LENGTH        : Int    = 2400;
    
    // Minimum allowed aperture in [f/stop]
    public static let MIN_APERTURE            : Double = 0.7;
    
    // Maximum allowed aperture in [f/stop]
    public static let MAX_APERTURE            : Double = 99.0;
    
    // Minimum allowed distance between camera and subject
    public static let MIN_DISTANCE            : Double = 0.01;
    
    // Maximum allowed distance between camera and subject
    public static let MAX_DISTANCE            : Double = 9999.0;
    
    // Allowed range for distance between camera and subject
    public static let DISTANCE_RANGE          : ClosedRange<Double> = MIN_DISTANCE...MAX_DISTANCE
    

    // Equatorial radius of WGS84 ellipsoid [m]
    public static let WGS84_a                 : Double = 6_378_137.0
    
    // Polar radius of WGS84 ellipsoid [m]
    public static let WGS84_b                 : Double = 6_356_752.3142
    
    // Camera height above ground
    public static let CAMERA_HEIGHT           : Double = 1.6

    // iOS menu font size
    public static let IOS_MENU_FONT_SIZE      : CGFloat = 13
    
    // iOS FovDataView font size
    public static let IOS_FOV_VIEW_FONT_SIZE  : CGFloat = 12
    
    // Default focal length
    public static let DEFAULT_FOCAL_LENGTH    : Int = 70

    // Default Aperture
    public static let DEFAULT_APERTURE        : Aperture = Aperture(uiString: "f/2.8", apiString: "f2_8", aperture: 2.8, apertureTc_1_4: 4.0, apertureTc_2_0: 5.6)

    // Default SensorFormat
    public static let DEFAULT_SENSOR_FORMAT   : SensorFormat = SensorFormat(uiString: "Full Format", apiString: "full_format", width: 36.0, height: 23.9, cropFactor: 1.0)
    
    // Default Orientation
    public static let DEFAULT_ORIENTATION     : Orientation = Orientation.LANDSCAPE
    
    // Default TeleComverter
    public static let DEFAULT_TELECONVERTER   : TeleConverter = TeleConverter(uiString: "None", apiString: "none", factor: 1.0)
    
    // Demo FovData
    public static let DEMO_FOV_DATA           : FovData     = Helper.getDemoFovData()
    
    // Demo data
    public static let DEMO_DATA = """
    {
      "camera_latitude": 51.96352544871728,
      "camera_longitude": 7.614071501010091,
      "subject_latitude": 51.963610683172625,
      "subject_longitude": 7.613079121122492,
      "sensor_format": "full_format",
      "sensor_width": 36.0,
      "sensor_height": 23.9,
      "focal_length": 15.0,
      "aperture": 2.8,
      "orientation": "landscape",
      "distance_to_subject": 68.86613822191748,
      "bearing": 170.00,
      "hyper_focal_distance": 2.785935960591133,
      "fov_width": 165.0671363287216,
      "fov_height": 110.04476969652731,
      "fov_width_angle": 175.08559029511184,
      "fov_height_angle": 134.82323594250937,
      "dof_near_limit": 2.664313496142132,
      "dof_far_limit": 10000.0,
      "dof_in_front": 66.20182472577535,
      "dof_behind": 10000.0,
      "dof_total": 10000.0,
      "max_subject_height": 56.62238484826366,
      "features": [
        {
          "type": "Feature",
          "geometry": {
            "type": "Polygon",
            "coordinates": [
              [
                [
                  51.96352544871728,
                  7.614071501010091
                ],
                [
                  51.96440642396936,
                  7.614713101606325
                ],
                [
                  51.96440642396936,
                  7.613429900413892
                ]
              ]
            ]
          },
          "properties": {
            "name": "fovTriangle"
          }
        },
        {
          "type": "Feature",
          "geometry": {
            "type": "Polygon",
            "coordinates": [
              [
                [
                  51.96354938265133,
                  7.614088931355737
                ],
                [
                  52.05333880738114,
                  7.679624405646387
                ],
                [
                  52.05333880738114,
                  7.54851859637383
                ],
                [
                  51.96354938265133,
                  7.614054070664378
                ]
              ]
            ]
          },
          "properties": {
            "name": "dofTrapezoid"
          }
        }
      ],
      "msg": ""
    }
    """.data(using: .utf8)!
}
