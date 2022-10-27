//
//  MeHungiApp.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/27/22.
//

import SwiftUI

@main
struct MeHungiApp: App {
    @StateObject var model: ModelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
