//
//  FramerSCApp.swift
//  FramerSC
//
//  Created by Gerrit Grunwald on 14.01.23.
//

import SwiftUI

@main
struct FramerSCApp: App {
    @ObservedObject var model : Model = Model()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
