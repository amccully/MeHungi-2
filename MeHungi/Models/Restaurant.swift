//
//  Restaurant.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/27/22.
//

import Foundation

class Restaurant: Identifiable, ObservableObject {
    let id: UUID = UUID()
    let name: String
    @Published var waitTime: Int
    
    init(name: String, waitTime: Int) {
        self.name = name
        self.waitTime = waitTime
    }
}
