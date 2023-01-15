//
//  MKPolygon+contains.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation
import MapKit


extension MKPolygon {
    func contains(coor: CLLocationCoordinate2D) -> Bool {
        let polygonRenderer : MKOverlayPathRenderer = MKPolygonRenderer(polygon: self)
        let currentMapPoint : MKMapPoint            = MKMapPoint(coor)
        let polygonViewPoint: CGPoint               = polygonRenderer.point(for: currentMapPoint)
        return polygonRenderer.path == nil ? false : polygonRenderer.path.contains(polygonViewPoint)        
    }
}
