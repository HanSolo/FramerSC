//
//  Helper.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation
import SwiftUI
import MapKit


public struct Helper {
    
    public static func clamp(min: Double, max: Double, value: Double) -> Double {
        if value < min { return min }
        if value > max { return max }
        return value
    }
    public static func clampLatitude(latitude: Double) -> Double {
        if latitude < -90 {
            return -90 - latitude.truncatingRemainder(dividingBy: 90.0)
        } else if latitude > 90 {
            return 90 - latitude.truncatingRemainder(dividingBy: 90.0)
        } else {
            return latitude
        }
    }
    public static func clampLongitude(longitude: Double) -> Double {
        if longitude < -180 {
            return 180 + longitude.truncatingRemainder(dividingBy: 180.0)
        } else if longitude > 180 {
            return -180 + longitude.truncatingRemainder(dividingBy: 180.0)
        } else {
            return longitude
        }
    }
    
    public static func calcDistanceInKilometers(location1: GeoLocation, location2: GeoLocation) -> Double {
        return calcDistanceInMeters(location1: location1, location2: location2) / 1000.0
    }
    public static func calcDistanceInMeters(location1: GeoLocation, location2: GeoLocation) -> Double {
        return self.calcDistanceInMeters(latitude1: location1.coordinate.latitude, longitude1: location1.coordinate.longitude, latitude2: location2.coordinate.latitude, longitude2: location2.coordinate.longitude)
    }
    public static func calcDistanceInMeters(latitude1: Double, longitude1: Double, latitude2: Double, longitude2: Double) -> Double {
        let lat1Radians     : Double = Math.toRadians(deg: latitude1)
        let lat2Radians     : Double = Math.toRadians(deg: latitude2)
        let deltaLatRadians : Double = Math.toRadians(deg: (latitude2 - latitude1))
        let deltaLonRadians : Double = Math.toRadians(deg: (longitude2 - longitude1))
        
        let a : Double = sin(deltaLatRadians * 0.5) * sin(deltaLatRadians * 0.5) + cos(lat1Radians) * cos(lat2Radians) * sin(deltaLonRadians * 0.5) * sin(deltaLonRadians * 0.5)
        let c : Double = 2 * atan2(sqrt(a), sqrt(1 - a))
        
        let distance : Double = Constants.WGS84_a * c
        return distance
    }
    
    public static func calcDistanceInMetersMorePrecise(location1: MKPointAnnotation, location2: MKPointAnnotation) -> Double {
        return calcDistanceInMetersMorePrecise(latitude1: location1.coordinate.latitude, longitude1: location1.coordinate.longitude, latitude2: location2.coordinate.latitude, longitude2: location2.coordinate.longitude)
    }
    public static func calcDistanceInMetersMorePrecise(location1: GeoLocation, location2: GeoLocation) -> Double {
        return calcDistanceInMetersMorePrecise(latitude1: location1.coordinate.latitude, longitude1: location1.coordinate.longitude, latitude2: location2.coordinate.latitude, longitude2: location2.coordinate.longitude)
    }
    public static func calcDistanceInMetersMorePrecise(latitude1: Double, longitude1: Double, latitude2: Double, longitude2: Double) -> Double {
        let maxIterations      : Int    = 20
        
        let lat1               : Double = Math.toRadians(deg: latitude1)
        let lat2               : Double = Math.toRadians(deg: latitude2)
        let lon1               : Double = Math.toRadians(deg: longitude1)
        let lon2               : Double = Math.toRadians(deg: longitude2)
                
        let f                  : Double = (Constants.WGS84_a - Constants.WGS84_b) / Constants.WGS84_a
        let aSqMinusBSqOverBSq : Double = (Constants.WGS84_a * Constants.WGS84_a - Constants.WGS84_b * Constants.WGS84_b) / (Constants.WGS84_b * Constants.WGS84_b)

        let L                  : Double = lon2 - lon1
        let U1                 : Double = atan((1.0 - f) * tan(lat1))
        let U2                 : Double = atan((1.0 - f) * tan(lat2))
        
        let cosU1              : Double = cos(U1)
        let cosU2              : Double = cos(U2)
        let sinU1              : Double = sin(U1)
        let sinU2              : Double = sin(U2)
        let cosU1cosU2         : Double = cosU1 * cosU2
        let sinU1sinU2         : Double = sinU1 * sinU2

        var A                  : Double = 0.0
        var sigma              : Double = 0.0
        var deltaSigma         : Double = 0.0
        var cosSqAlpha         : Double = 0.0
        var cos2SM             : Double = 0.0
        var cosSigma           : Double = 0.0
        var sinSigma           : Double = 0.0
        var cosLambda          : Double = 0.0
        var sinLambda          : Double = 0.0
        var lambda             : Double = L
        
        for _ in 0..<maxIterations {
            let lambdaOrig : Double = lambda
            cosLambda = cos(lambda)
            sinLambda = sin(lambda)

            let t1         : Double = cosU2 * sinLambda
            let t2         : Double = cosU1 * sinU2 - sinU1 * cosU2 * cosLambda
            let sinSqSigma : Double = t1 * t1 + t2 * t2
            sinSigma = sqrt(sinSqSigma)
            cosSigma = sinU1sinU2 + cosU1cosU2 * cosLambda
            sigma    = atan2(sinSigma, cosSigma)

            let sinAlpha : Double = (sinSigma == 0) ? 0.0 : cosU1cosU2 * sinLambda / sinSigma
            cosSqAlpha = 1.0 - sinAlpha * sinAlpha
            cos2SM     = (cosSqAlpha == 0) ? 0.0 : cosSigma - 2.0 * sinU1sinU2 / cosSqAlpha

            let uSquared : Double = cosSqAlpha * aSqMinusBSqOverBSq
            A = 1 + (uSquared / 16384.0) * (4096.0 + uSquared * (-768 + uSquared * (320.0 - 175.0 * uSquared)))

            let B        : Double = (uSquared / 1024.0) * (256.0 + uSquared * (-128.0 + uSquared * (74.0 - 47.0 * uSquared)))
            let C        : Double = (f / 16.0) * cosSqAlpha * (4.0 + f * (4.0 - 3.0 * cosSqAlpha))
            let cos2SMSq : Double = cos2SM * cos2SM
            deltaSigma = B * sinSigma * (cos2SM + (B / 4.0) * (cosSigma * (-1.0 + 2.0 * cos2SMSq) - (B / 6.0) * cos2SM * (-3.0 + 4.0 * sinSigma * sinSigma) * (-3.0 + 4.0 * cos2SMSq)))
            lambda     = L + (1.0 - C) * f * sinAlpha * (sigma + C * sinSigma * (cos2SM + C * cosSigma * (-1.0 + 2.0 * cos2SM * cos2SM)))

            let delta : Double = (lambda - lambdaOrig) / lambda
            if abs(delta) < 1.0e-12 { break }
        }

        let distance : Double = (Constants.WGS84_b * A * (sigma - deltaSigma))
        return distance
    }
    
    public static func calcBearingInDegree(location1: GeoLocation, location2: GeoLocation) -> Double {
        return calcBearingInDegree(latitude1: location1.coordinate.latitude, longitude1: location1.coordinate.longitude, latitude2: location2.coordinate.latitude, longitude2: location2.coordinate.longitude)
    }
    public static func calcBearingInDegree(latitude1: Double, longitude1: Double, latitude2: Double, longitude2: Double) -> Double {
        let lat1     : Double = Math.toRadians(deg: latitude1)
        let lon1     : Double = Math.toRadians(deg: longitude1)
        let lat2     : Double = Math.toRadians(deg: latitude2)
        let lon2     : Double = Math.toRadians(deg: longitude2)
        var deltaLon : Double = lon2 - lon1
        let deltaPhi : Double = log(tan(lat2 * 0.5 + .pi * 0.25) / tan(lat1 * 0.5 + .pi * 0.25))
        if abs(deltaLon) > .pi {
            if deltaLon > 0 {
                deltaLon = -(2.0 * .pi - deltaLon)
            } else {
                deltaLon = (2.0 * .pi + deltaLon)
            }
        }
        let bearing  : Double = Math.toDegrees(rad: (atan2(deltaLon, deltaPhi)) + 360.0).truncatingRemainder(dividingBy: 360.0)
        return bearing
    }
    
    public static func getCardinalDirectionFromBearing(bearing: Double) -> CardinalDirection {
        let brng : Double = bearing.truncatingRemainder(dividingBy: 360.0)
        for cardinalDirection in CardinalDirection.allCases {
            if brng >= cardinalDirection.fromTo.0 && brng < cardinalDirection.fromTo.1 { return cardinalDirection }
        }
        return CardinalDirection.NOT_FOUND
    }
    
    public static func getDemoFovData() -> FovData {
        let decoder : JSONDecoder = JSONDecoder()
        let decodedData = try! decoder.decode(FovData.self, from: Constants.DEMO_DATA)
        return decodedData
    }
    
    public static func getFovData(json: String) -> FovData {
        let decoder : JSONDecoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(FovData.self, from: json.data(using: .utf8)!)
            return decodedData
        } catch {
            return getDemoFovData()
        }
        
    }

    private static func getBaseUrlComponents() -> URLComponents {
        var components : URLComponents = URLComponents()
        components.scheme = Constants.PROTOCOL
        components.host   = Constants.HOST
        components.port   = Constants.PORT
        return components
    }
        
    
    public static func findNearby(searchText: String, region: MKCoordinateRegion, completion: @escaping ([MKMapItem]) ->()) {
        var items         : [MKMapItem]           = [MKMapItem]()
        let searchRequest : MKLocalSearch.Request = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText
        searchRequest.region               = region
                
        let search : MKLocalSearch = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            items.append(contentsOf: response.mapItems)
            completion(items)
        }
    }
    
    
    // Field of view calculation call
    public static func calcFov(cameraLocation: GeoLocation, subjectLocation: GeoLocation, focalLength: Int, aperture: Double, sensorFormat: SensorFormat, orientation: Orientation) async -> FovData {
        return await calcFov(latitude1: cameraLocation.coordinate.latitude, longitude1: cameraLocation.coordinate.longitude, latitude2: subjectLocation.coordinate.latitude, longitude2: subjectLocation.coordinate.longitude, focalLength: focalLength, aperture: aperture, sensorFormat: sensorFormat, orientation: orientation)
    }
    public static func calcFov(latitude1: Double, longitude1: Double, latitude2: Double, longitude2: Double, focalLength: Int, aperture: Double, sensorFormat: SensorFormat, orientation: Orientation) async -> FovData {
        var components : URLComponents = getBaseUrlComponents()
        components.path = Constants.CALC_FOV_PATH
        components.queryItems = [
            URLQueryItem(name: "latitude1", value: latitude1.description),
            URLQueryItem(name: "longitude1", value: longitude1.description),
            URLQueryItem(name: "latitude2", value: latitude2.description),
            URLQueryItem(name: "longitude2", value: longitude2.description),
            URLQueryItem(name: "focal_length", value: focalLength.description),
            URLQueryItem(name: "aperture", value: aperture.description),
            URLQueryItem(name: "sensor_format", value: sensorFormat.apiString),
            URLQueryItem(name: "orientation", value: orientation.apiString)
        ]
        
        // Create the HTTP request
        let url         : URL         = URL(string: components.string!)!
        let request     : URLRequest  = URLRequest(url: url)
        let decodedData : FovData?    = try? await performCallToCalcFov(request)
        return decodedData ?? getDemoFovData()
    }
    private static func performCallToCalcFov(_ request: URLRequest) async throws -> FovData {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<400).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        let decoder     : JSONDecoder = JSONDecoder()
        let decodedData : FovData = try! decoder.decode(FovData.self, from: data)
        
        return decodedData
    }
        
    // TeleConverter calculation call
    public static func calcTc(focalLength : Int, aperture: Aperture, teleConverter: TeleConverter) async -> (Int, Double) {
        var components : URLComponents = getBaseUrlComponents()
        components.path = Constants.CALC_TC_PATH
        components.queryItems = [
            URLQueryItem(name: "focal_length", value: focalLength.description),
            URLQueryItem(name: "aperture", value: aperture.aperture.description),
            URLQueryItem(name: "tc", value: teleConverter.apiString)
        ]
        
        // Create the HTTP request
        let url     : URL           = URL(string: components.string!)!
        let request : URLRequest    = URLRequest(url: url)
        let result  : (Int, Double) = try! await performCallToCalcTc(request)
        return result
    }
    private static func performCallToCalcTc(_ request: URLRequest) async throws -> (Int, Double) {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<400).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        var convertedFocalLength : Int    = 0
        var convertedAperture    : Double = 0
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let cfl = json["converted_foacl_length"] as? Int {
                    convertedFocalLength = cfl
                }
                if let ca = json["converted_aperture"] as? Double {
                    convertedAperture = ca
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        return (convertedFocalLength, convertedAperture)
    }
    
    // Apertures call
    public static func getApertures() async -> [Aperture] {
        var components : URLComponents = getBaseUrlComponents()
        components.path = Constants.APERTURES_PATH
        
        // Create the HTTP request
        let url     : URL        = URL(string: components.string!)!
        let request : URLRequest = URLRequest(url: url)
        let result  : [Aperture] = try! await performCallToApertures(request)
        return result
    }
    private static func performCallToApertures(_ request: URLRequest) async throws -> [Aperture] {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<400).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder   : JSONDecoder = JSONDecoder()
        let apertures : [Aperture]  = try! decoder.decode([Aperture].self, from: data)
        return apertures
    }
    
    // Sensors call
    public static func getSensors() async -> [SensorFormat] {
        var components : URLComponents = getBaseUrlComponents()
        components.path = Constants.SENSORS_PATH
        
        // Create the HTTP request
        let url     : URL            = URL(string: components.string!)!
        let request : URLRequest     = URLRequest(url: url)
        let result  : [SensorFormat] = try! await performCallToSensors(request)
        return result
    }
    private static func performCallToSensors(_ request: URLRequest) async throws -> [SensorFormat] {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<400).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder : JSONDecoder    = JSONDecoder()
        let sensors : [SensorFormat] = try! decoder.decode([SensorFormat].self, from: data)
        return sensors
    }
    
    // TeleConverters call
    public static func getTeleConverters() async -> [TeleConverter] {
        var components : URLComponents = getBaseUrlComponents()
        components.path = Constants.TELECONVERTERS_PATH
        
        // Create the HTTP request
        let url     : URL             = URL(string: components.string!)!
        let request : URLRequest      = URLRequest(url: url)
        let result  : [TeleConverter] = try! await performCallToTeleConverters(request)
        return result
    }
    private static func performCallToTeleConverters(_ request: URLRequest) async throws -> [TeleConverter] {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<400).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder        : JSONDecoder     = JSONDecoder()
        let teleconverters : [TeleConverter] = try! decoder.decode([TeleConverter].self, from: data)
        return teleconverters
    }
}
