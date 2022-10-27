//
//  ModelData.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/27/22.
//

import Foundation

class ModelData: ObservableObject {
    @Published var restaurants: [Restaurant] = [
        Restaurant(name: "Subway", waitTime: 30),
        Restaurant(name: "Panda", waitTime: 5),
        Restaurant(name: "Burger King", waitTime: 0),
        Restaurant(name: "Santorini's", waitTime: 3)
    ]
}
