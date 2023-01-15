//
//  MKPointAnnotation+equals.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation
import MapKit
import AdvancedMap


extension MKPointAnnotation {

  public override func isEqual(_ object: Any?) -> Bool {
      guard let other = object as? Self else { return false }
      return coordinate == other.coordinate && title == other.title && subtitle == other.subtitle
  }

  static let annotationViewFactory = AnnotationViewFactory(register: { mapView in
      mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: String(describing: MKPointAnnotation.self))
  }, view: { mapView, annotation in
      let view = mapView.dequeueReusableAnnotationView(withIdentifier: String(describing: MKPointAnnotation.self), for: annotation)
      //view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.title ?? "")
      //view.canShowCallout = true
      //view.image = NSImage(name: "camera.circle.fill")
  #if os(iOS) || os(macOS)
      (view as? MKMarkerAnnotationView)?.isDraggable    = true
      (view as? MKMarkerAnnotationView)?.canShowCallout = true
  #endif
      return view
  })
}
