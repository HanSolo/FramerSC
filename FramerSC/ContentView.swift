//
//  ContentView1.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation
import AdvancedMap
import MapKit
import SwiftUI
import UniformTypeIdentifiers
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif


struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject          var model              : Model
    @State                      var mapRect            : MKMapRect?              = nil
    @State                      var region             : MKCoordinateRegion?     = nil
    @State                      var overlays           : [MKOverlay]             = [MKOverlay]()
    @State                      var annotations        : [MKPointAnnotation]     = [MKPointAnnotation]()
    @State                      var distance           : Double?                 = nil
    @State                      var fovData            : FovData?                = nil { didSet { updateOverlays() } }
    @State                      var focalLength        : Int                     = Constants.DEFAULT_FOCAL_LENGTH
    @State                      var aperture           : Aperture                = Constants.DEFAULT_APERTURE
    @State                      var sensorFormat       : SensorFormat            = Constants.DEFAULT_SENSOR_FORMAT
    @State                      var orientation        : Orientation             = Constants.DEFAULT_ORIENTATION
    @State                      var teleconverter      : TeleConverter           = Constants.DEFAULT_TELECONVERTER
    @State                      var showPopover        : Bool                    = false
    @State                      var showDofTrapezoid   : Bool                    = true {
        didSet {
            #if os(macOS)
            self.dofTrapezoidFill   = showDofTrapezoid ? Constants.DOF_TRAPEZOID_FILL   : NSColor.clear
            self.dofTrapezoidStroke = showDofTrapezoid ? Constants.DOF_TRAPEZOID_STROKE : NSColor.clear
            #elseif os(iOS)
            self.dofTrapezoidFill   = showDofTrapezoid ? Constants.DOF_TRAPEZOID_FILL   : UIColor.clear
            self.dofTrapezoidStroke = showDofTrapezoid ? Constants.DOF_TRAPEZOID_STROKE : UIColor.clear
            #endif
        }
    }
    #if os(macOS)
    @State                      var dofTrapezoidFill   : NSColor                 = Constants.DOF_TRAPEZOID_FILL
    @State                      var dofTrapezoidStroke : NSColor                 = Constants.DOF_TRAPEZOID_STROKE
    #elseif os(iOS)
    @State                      var dofTrapezoidFill   : UIColor                 = Constants.DOF_TRAPEZOID_FILL
    @State                      var dofTrapezoidStroke : UIColor                 = Constants.DOF_TRAPEZOID_STROKE
    #endif
    #if os(iOS) || os(macOS)
        @State                  var userTrackingMode   : MKUserTrackingMode      = .follow
    #endif

    
    
    var body: some View {
        VStack {
            #if os(macOS)
            HStack {
                Picker("Focal Length", selection: $focalLength) {
                    ForEach(self.model.focalLengths, id: \.self) {
                        Text($0.description)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 150)
                .onChange(of: focalLength) { newValue in
                    updateFovData()
                }
                
                Picker("Aperture", selection: $aperture) {
                    ForEach(self.model.apertures, id: \.self) {
                        Text($0.uiString)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 130)
                .onChange(of: aperture) { newValue in
                    updateFovData()
                }
                
                Picker("Sensor", selection: $sensorFormat) {
                    ForEach(self.model.sensors, id: \.self) {
                        Text($0.uiString)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 180)
                .onChange(of: sensorFormat) { newValue in
                    updateFovData()
                }
                
                Picker("Orientation", selection: $orientation) {
                    ForEach(self.model.orientations, id: \.self) {
                        Text($0.uiString)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 180)
                .onChange(of: orientation) { newValue in
                    updateFovData()
                }
                
                Picker("TeleConverter", selection: $teleconverter) {
                    ForEach(self.model.teleconverters, id: \.self) {
                        Text($0.uiString)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 180)
                .onChange(of: teleconverter) { newValue in
                    updateFovData()
                }
                
                Spacer()
                                
                HStack(spacing: 10) {
                    /*
                    Toggle("DoF", isOn: $showDofTrapezoid)
                        .help("Show/Hide depth of field trapezoiod")
                    */
                    Button(action: {
                        let encoder : JSONEncoder = JSONEncoder()
                        encoder.outputFormatting = .prettyPrinted
                        do {
                            let data : Data   = try encoder.encode(self.fovData)
                            let json : String = String(data: data, encoding: .utf8) ?? ""
                            let pasteBoard = NSPasteboard.general
                            pasteBoard.clearContents()
                            pasteBoard.setString(json, forType: NSPasteboard.PasteboardType.string)
                        } catch {
                            
                        }
                    }) {
                        Image(systemName: "doc.on.doc")
                    }
                    .disabled(self.fovData == nil)
                    .help("Copy to clipboard")
                    
                    Button(action: {
                        let pasteBoard = NSPasteboard.general
                        let json       = pasteBoard.string(forType: NSPasteboard.PasteboardType.string) ?? ""
                        setFovData(fovData: Helper.getFovData(json: json))
                        updateOverlays()
                    }) {
                        Image(systemName: "doc.on.clipboard")
                    }
                    .help("Paste from clipboard")
                    
                    Button(action: {
                        self.overlays.removeAll()
                        self.annotations.removeAll()
                        @State var userTrackingMode: MKUserTrackingMode = .follow
                    }) {
                        Image(systemName: "clear")
                    }
                    .help("Reset")                                        
                }
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            #elseif os(iOS)
            HStack(spacing: 30) {
                VStack(spacing: 20) {
                    Menu {
                        Picker(selection: $focalLength) {
                            ForEach(self.model.focalLengths, id: \.self) { value in
                                Text("\(value.description) mm")
                                    .tag(value)
                                    .font(.system(size: Constants.IOS_MENU_FONT_SIZE))
                            }
                        } label: {}
                    } label: {
                        Text("\(self.focalLength.description) mm")
                            .font(.system(size: Constants.IOS_MENU_FONT_SIZE))
                    }.onChange(of: focalLength) { newValue in
                        updateFovData()
                    }
                    
                    Menu {
                        Picker(selection: $aperture) {
                            ForEach(self.model.apertures, id: \.self) { value in
                                Text(value.uiString)
                                    .tag(value)
                                    .font(.system(size: Constants.IOS_MENU_FONT_SIZE))
                            }
                        } label: {}
                    } label: {
                        Text(self.aperture.uiString)
                            .font(.system(size: Constants.IOS_MENU_FONT_SIZE))
                    }.onChange(of: aperture) { newValue in
                        updateFovData()
                    }
                }
                VStack(spacing: 20) {
                    Menu {
                        Picker(selection: $sensorFormat) {
                            ForEach(self.model.sensors, id: \.self) { value in
                                Text(value.uiString)
                                    .tag(value)
                                    .font(.system(size: Constants.IOS_MENU_FONT_SIZE))
                            }
                        } label: {}
                    } label: {
                        Text(self.sensorFormat.uiString)
                            .font(.system(size: Constants.IOS_MENU_FONT_SIZE))
                    }.onChange(of: sensorFormat) { newValue in
                        updateFovData()
                    }
                    
                    Menu {
                        Picker(selection: $orientation) {
                            ForEach(self.model.orientations, id: \.self) { value in
                                Text(value.uiString)
                                    .tag(value)
                                    .font(.system(size: Constants.IOS_MENU_FONT_SIZE))
                            }
                        } label: {}
                    } label: {
                        Text(self.orientation.uiString)
                            .font(.system(size: Constants.IOS_MENU_FONT_SIZE))
                    }.onChange(of: orientation) { newValue in
                        updateFovData()
                    }
                }
                VStack(spacing: 20) {
                    Menu {
                        Picker(selection: $teleconverter) {
                            ForEach(self.model.teleconverters, id: \.self) { value in
                                Text(value.uiString)
                                    .tag(value)
                                    .font(.system(size: Constants.IOS_MENU_FONT_SIZE))
                            }
                        } label: {}
                    } label: {
                        Text(self.teleconverter.uiString)
                            .font(.system(size: Constants.IOS_MENU_FONT_SIZE))
                    }.onChange(of: teleconverter) { newValue in
                        updateFovData()
                    }
                }
                //Spacer()
                HStack(spacing: 15) {
                    Button(action: {
                        let encoder : JSONEncoder = JSONEncoder()
                        encoder.outputFormatting = .prettyPrinted
                        do {
                            let data : Data   = try encoder.encode(self.fovData)
                            let json : String = String(data: data, encoding: .utf8) ?? ""
                            UIPasteboard.general.setValue(json, forPasteboardType: "public.plain-text")
                        } catch {
                            
                        }
                    }) {
                        Image(systemName: "doc.on.doc")
                    }
                    .disabled(self.fovData == nil)
                    .help("Copy to clipboard")
                    
                    Button(action: {
                        let pasteBoard = UIPasteboard.general
                        let json       = pasteBoard.string ?? ""
                        setFovData(fovData: Helper.getFovData(json: json))
                        updateOverlays()
                    }) {
                        Image(systemName: "doc.on.clipboard")
                    }
                    .help("Paste from clipboard")
                    
                    Button(action: {
                        self.overlays.removeAll()
                        self.annotations.removeAll()
                        @State var userTrackingMode: MKUserTrackingMode = .follow
                    }) {
                        Image(systemName: "clear")
                    }
                    .help("Reset")
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            #endif
            
            HStack {
                #if os(iOS)
                ZStack(alignment: .bottom) {
                    map
                        .ignoresSafeArea()
                        .environment(\.colorScheme, .light)
                        .onAppear {
                            CLLocationManager().requestWhenInUseAuthorization()
                            CLLocationManager().startUpdatingLocation()
                        }
                    
                    FovDataViewIOS(fovData: $fovData)
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
                        .padding(EdgeInsets(top:0, leading:0, bottom: 0, trailing: 0))
                }
                #elseif os(macOS)
                ZStack(alignment: .top) {
                    map
                        .ignoresSafeArea()
                        .environment(\.colorScheme, .light)
                        .onAppear {
                            CLLocationManager().requestWhenInUseAuthorization()
                            CLLocationManager().startUpdatingLocation()
                        }
                    HStack(alignment: .top) {
                        Spacer()
                        FovDataViewMacOS(fovData: $fovData)
                            .padding(EdgeInsets(top:0, leading:0, bottom: 0, trailing: 0))
                    }
                }
                #endif
            }
        }
    }

    var map: some View {
        #if os(iOS)
        AdvancedMap(
            mapRect               : $mapRect,
            userTrackingMode      : $userTrackingMode,
            showsUserLocation     : true,
            isZoomEnabled         : true,
            isScrollEnabled       : true,
            isRotateEnabled       : true,
            isPitchEnabled        : true,
            showsCompass          : true,
            showsScale            : true,
            annotations           : annotations,
            annotationViewFactory : annotationViewFacotry(),
            overlays              : overlays,
            overlayRendererFactory: overlayRendererFactory(),
            tapOrClickHandler     : tapOrClickHandler,
            annotationDragHandler : annotationDragHandler
        )
        #elseif os(macOS)
        AdvancedMap(
            configuration         : .standard(.default, .realistic, .includingAll, true),
            //configuration         : .hybrid(.realistic, .includingAll, false),
            //configuration         : .imagery(.realistic),
            mapRect               : $mapRect,
            userTrackingMode      : $userTrackingMode,
            showsUserLocation     : true,
            isZoomEnabled         : true,
            isScrollEnabled       : true,
            isRotateEnabled       : true,
            isPitchEnabled        : true,
            showsPitchControl     : true,
            showsZoomControls     : true,
            showsCompass          : true,
            showsScale            : true,
            annotations           : annotations,
            annotationViewFactory : annotationViewFacotry(),
            overlays              : overlays,
            overlayRendererFactory: overlayRendererFactory(),
            tapOrClickHandler     : tapOrClickHandler,
            annotationDragHandler : annotationDragHandler
        )
        #endif
    }
    
    
    func updateFovData() {
        let noOfAnnotations : Int = self.annotations.count
        if noOfAnnotations == 2 {
            let camera  : MKPointAnnotation = self.annotations[0]
            let subject : MKPointAnnotation = self.annotations[1]
            let tc      : TeleConverter     = self.teleconverter
            let fl      : Int               = tc == Constants.DEFAULT_TELECONVERTER ? self.focalLength : Int(Double(self.focalLength) * tc.factor)
            let ap      : Double
            if tc.apiString == "tc_1_4" {
                ap = self.aperture.apertureTc_1_4
            } else if tc.apiString == "tc_2_0" {
                ap = self.aperture.apertureTc_2_0
            } else {
                ap = self.aperture.aperture
            }
            Task {
                self.fovData = await Helper.calcFov(latitude1: camera.coordinate.latitude, longitude1: camera.coordinate.longitude, latitude2: subject.coordinate.latitude, longitude2: subject.coordinate.longitude, focalLength: fl, aperture: ap, sensorFormat: self.sensorFormat, orientation: self.orientation)
            }
        }
    }
    
    func setFovData(fovData: FovData) -> Void {
        #if os(iOS) || os(macOS)
        @State var userTrackingMode: MKUserTrackingMode = .none
        #endif
        
        self.overlays.removeAll()
        self.annotations.removeAll()
                
        self.focalLength  = fovData.focal_length
        for (_, value) in self.model.apertures.enumerated() {
            if value.aperture == fovData.aperture {
                self.aperture = value
            }
        }
        for (_, value) in self.model.sensors.enumerated() {
            if value.apiString == fovData.sensor_format {
                self.sensorFormat = value
            }
        }
        for (_, value) in self.model.orientations.enumerated() {
            if value.apiString == fovData.orientation {
                self.orientation = value
            }
        }
        
        let camera : MKPointAnnotation = MKPointAnnotation()
        camera.coordinate = CLLocationCoordinate2D(latitude: fovData.camera_latitude, longitude: fovData.camera_longitude)
        camera.title      = "C"
        camera.subtitle   = "Camera"
        self.annotations.append(camera)
        
        let subject : MKPointAnnotation = MKPointAnnotation()
        subject.coordinate = CLLocationCoordinate2D(latitude: fovData.subject_latitude, longitude: fovData.subject_longitude)
        subject.title      = "S"
        subject.subtitle   = "Subject"
        self.annotations.append(subject)
        
        let distanceLine : MKPolyline = MKPolyline(coordinates: [camera.coordinate, subject.coordinate], count: 2)
        distanceLine.title = "\(String(format: "%.2f", distance ?? 0))m"
        
        let fovTriangle  : MKPolygon = (fovData.getFovTriangle().getPolygon())
        let dofTrapezoid : MKPolygon = (fovData.getDofTrapezoid().getPolygon())
        
        self.overlays.append(distanceLine)
        self.overlays.append(fovTriangle)
        self.overlays.append(dofTrapezoid)
                
        self.fovData = fovData
        
        // Move map to new coordinate
        moveTo(coordinate: camera.coordinate)        
    }
    
    func updateOverlays() {
        let noOfAnnotations : Int = self.annotations.count
        if noOfAnnotations == 2 {
            let camera   : MKPointAnnotation = self.annotations[0]
            let subject  : MKPointAnnotation = self.annotations[1]
            self.distance = Helper.calcDistanceInMetersMorePrecise(location1: camera, location2: subject)

            if Constants.DISTANCE_RANGE.contains(distance ?? 0) {
                let distanceLine : MKPolyline = MKPolyline(coordinates: [camera.coordinate, subject.coordinate], count: 2)
                distanceLine.title = "\(String(format: "%.2f", distance ?? 0))m"
                if self.fovData != nil {
                    self.overlays.removeAll()
                    let fovTriangle  : MKPolygon = (self.fovData?.getFovTriangle().getPolygon())!
                    let dofTrapezoid : MKPolygon = (self.fovData?.getDofTrapezoid().getPolygon())!
                    self.overlays.append(distanceLine)
                    self.overlays.append(fovTriangle)
                    self.overlays.append(dofTrapezoid)
                } else {
                    self.overlays.append(distanceLine)
                }
            } else {
                self.overlays.removeAll()
            }
        }
    }

    func moveTo(coordinate: CLLocationCoordinate2D) -> Void {
        var r  : MKMapRect  = self.mapRect!
        let pt : MKMapPoint = MKMapPoint(coordinate)
        r.origin.x = pt.x - r.size.width * 0.5
        r.origin.y = pt.y - r.size.height * 0.5
        self.mapRect?.origin = r.origin
    }
    
    func annotationViewFacotry() -> AnnotationViewFactory {
        .combine(
            MKUserLocation.mkUserLocationViewFactory,
            MKPointAnnotation.annotationViewFactory
        )
    }

    func overlayRendererFactory() -> OverlayRendererFactory {
        .factory(for: MKOverlay.self) { overlay in
            let renderer : MKOverlayPathRenderer
            if let polyline = overlay as? MKPolyline {
                renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .red
                renderer.lineWidth   = 1
            } else if let polygon = overlay as? MKPolygon {
                renderer = MKPolygonRenderer(polygon: polygon)
                
                if polygon.pointCount == 3 {                    
                    renderer.strokeColor = Constants.FOV_TRIANGLE_STROKE
                    renderer.lineWidth   = 1
                    renderer.fillColor   = Constants.FOV_TRIANGLE_FILL
                } else {
                    renderer.strokeColor = $dofTrapezoidStroke.wrappedValue
                    renderer.lineWidth   = 1
                    renderer.fillColor   = $dofTrapezoidFill.wrappedValue
                }
            } else {
                renderer = MKPolylineRenderer()
            }
            return renderer
        }
    }

    func tapOrClickHandler(location: CLLocationCoordinate2D) {
        let noOfAnnotations : Int               = self.annotations.count
        let annotation      : MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate  = location
        annotation.title       = noOfAnnotations == 0 ? "C" : "S"
        annotation.subtitle    = noOfAnnotations == 0 ? "Camera" : "Subject"
        
        if self.overlays.count > 0 {
            let polygons = self.overlays.compactMap { $0 as? MKPolygon }
            if polygons.count > 0 {
                if polygons[0].contains(coor: location) {
                    // Do something when tapped on fovTriangle
                    self.showPopover = !self.showPopover
                }
            }
        }
        
        if noOfAnnotations == 2 { return }
        self.annotations.append(annotation)
        
        // Set teleconverter to none as long as not camera and subject selected
        self.teleconverter = Constants.DEFAULT_TELECONVERTER
        
        if self.annotations.count == 2 {
            Task {
                let camera  : MKPointAnnotation = self.annotations[0]
                let subject : MKPointAnnotation = self.annotations[1]
                self.fovData = await Helper.calcFov(latitude1: camera.coordinate.latitude, longitude1: camera.coordinate.longitude,
                                                    latitude2: subject.coordinate.latitude, longitude2: subject.coordinate.longitude,
                                                    focalLength: self.focalLength, aperture: self.aperture.aperture,
                                                    sensorFormat: self.sensorFormat, orientation: self.orientation)
            }
        } else {
            updateOverlays()
        }
    }

    func annotationDragHandler(annotation: MKAnnotation, location: CLLocationCoordinate2D, oldState: MKAnnotationView.DragState, newState: MKAnnotationView.DragState) {
        guard let index = self.annotations.firstIndex(where: { pointAnnotation in
            pointAnnotation === annotation
    }) else { return }
        self.annotations[index].coordinate = location
        if self.annotations.count == 2 {
            Task {
                let camera  : MKPointAnnotation = self.annotations[0]
                let subject : MKPointAnnotation = self.annotations[1]
                self.fovData = await Helper.calcFov(latitude1: camera.coordinate.latitude, longitude1: camera.coordinate.longitude, latitude2: subject.coordinate.latitude, longitude2: subject.coordinate.longitude, focalLength: self.focalLength, aperture: self.aperture.aperture, sensorFormat: self.sensorFormat, orientation: self.orientation)
                updateOverlays()
            }
        } else {
            updateOverlays()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
        
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
    }
}
