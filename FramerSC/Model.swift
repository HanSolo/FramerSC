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
    @Published var focalLengths   : [Int]           = [8, 10, 11, 12, 14, 15, 16, 17, 18, 20, 22, 24, 28, 30, 35, 40, 45, 50, 55, 56, 58, 60, 65, 70, 75, 80, 85, 90, 100, 105, 110, 120, 135, 140, 150, 180, 200, 210, 240, 250, 300, 350, 400, 500, 600, 800, 1000, 1200]
    @Published var apertures      : [Aperture]      = []
    @Published var isos           : [ISO]           = []
    @Published var teleconverters : [TeleConverter] = []
    @Published var orientations   : [Orientation]   = [ Orientation.LANDSCAPE, Orientation.PORTRAIT ]
    
    
    @MainActor
    init() {
        Task {
            self.sensors        = await Helper.getSensors()
            self.apertures      = await Helper.getApertures()
            self.isos           = await Helper.getIsos()
            self.teleconverters = await Helper.getTeleConverters()
            self.teleconverters.insert(Constants.DEFAULT_TELECONVERTER, at: 0)
        }
    }
}
