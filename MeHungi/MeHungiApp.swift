//
//  MeHungiApp.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/27/22.
//
//  we want server to handle all information that will be the same for every device
//  press enter to autofill
//  keep things simple for json files, so 4 simple ints is better than 1 string that you need to extract info from
//  SwiftOnTap: guide for swiftui
//  fuck optimization! keep it simple
//  use plus button in top right to access sf symbol library
//  some stuff is harder coded, such as frame size! adjust in the future!

import SwiftUI

@main
struct MeHungiApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
