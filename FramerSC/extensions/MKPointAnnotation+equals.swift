//
//  MKPointAnnotation+equals.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation
import MapKit
import AdvancedMap
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif


extension MKPointAnnotation {

  public override func isEqual(_ object: Any?) -> Bool {
      guard let other = object as? Self else { return false }
      return coordinate == other.coordinate && title == other.title && subtitle == other.subtitle
  }

  static let annotationViewFactory = AnnotationViewFactory(register: { mapView in
      mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: String(describing: MKAnnotation.self))
  }, view: { mapView, annotation in
      let view : MKAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: String(describing: MKAnnotation.self), for: annotation)
      var mView = view as! MKMarkerAnnotationView
      
      switch annotation.title {
          case "C":
              #if os(iOS)
              mView.image = UIImage(systemName: "camera.circle.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle: .body, scale: .default))
              //mView.image = UIImage(systemName: "camera.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 10, weight: .regular, scale: .default))?.withTintColor(.red)
              mView.tintColor       = .red
              mView.markerTintColor = .clear
              mView.glyphTintColor  = .clear
              mView.centerOffset    = CGPoint(x: 0.5, y: 0.7)
              #elseif os(macOS)
              var config = NSImage.SymbolConfiguration(textStyle: .headline, scale: .large)
              //var config = NSImage.SymbolConfiguration(pointSize: 16, weight: .regular, scale: .large)
              config = config.applying(.init(paletteColors: [.white, .black]))
              mView.image = NSImage(systemSymbolName: "camera.circle.fill", accessibilityDescription: "Camera")?.withSymbolConfiguration(config)
              mView.markerTintColor = .clear
              mView.glyphTintColor  = .clear
              mView.centerOffset    = CGPoint(x: 0.5, y: 0.7)
              #endif
              print("Camera")
          case "S":
              #if os(iOS)
              mView.image = UIImage(systemName: "camera.metering.center.weighted.average", withConfiguration: UIImage.SymbolConfiguration(textStyle: .body, scale: .default))
              mView.markerTintColor = .clear
              mView.glyphTintColor  = .clear
              mView.centerOffset    = CGPoint(x: 0.5, y: 0.7)          
              #elseif os(macOS)
              var config = NSImage.SymbolConfiguration(textStyle: NSFont.TextStyle.headline , scale: .large)
              //var config = NSImage.SymbolConfiguration(pointSize: 16, weight: .regular, scale: .large)
              config = config.applying(.init(paletteColors: [.black]))
              mView.image = NSImage(systemSymbolName: "camera.metering.center.weighted.average", accessibilityDescription: "Subject")?.withSymbolConfiguration(config)
              mView.markerTintColor = .clear
              mView.glyphTintColor  = .clear
              mView.centerOffset    = CGPoint(x: 0.5, y: 0.7)
              #endif
              print("Subject")
          default:
              break
      }
      
      
      //view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.title ?? "")
      //view.canShowCallout = true
      //view.image = NSImage(systemSymbolName: "camera.circle.fill", accessibilityDescription: "Camera")
  #if os(iOS) || os(macOS)
      (view as? MKMarkerAnnotationView)?.isDraggable    = true
      (view as? MKMarkerAnnotationView)?.canShowCallout = true
  #endif
      return view
  })
}
