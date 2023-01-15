//
//  Model.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import Foundation
import MapKit


public class Model : ObservableObject {
    @Published var sensors        : [SensorFormat]  = []
    @Published var focalLengths   : [Int]           = [11, 12, 14, 15, 16, 18, 20, 24, 30, 35, 40, 45, 50, 60, 70, 85, 90, 100, 105, 200, 300, 400, 500, 600, 800]
    @Published var apertures      : [Aperture]      = []
    @Published var teleconverters : [TeleConverter] = []
    @Published var orientations   : [Orientation]   = [ Orientation.LANDSCAPE, Orientation.PORTRAIT ]
    
    
    @MainActor
    init() {
        Task {
            self.sensors        = await Helper.getSensors()
            self.apertures      = await Helper.getApertures()
            self.teleconverters = await Helper.getTeleConverters()
            self.teleconverters.insert(Constants.DEFAULT_TELECONVERTER, at: 0)
        }
    }
}
