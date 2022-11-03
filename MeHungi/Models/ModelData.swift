//
//  ModelData.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/27/22.
//

import Foundation

class ModelData: ObservableObject {
        
    @Published var restaurants: [Restaurant] = [Restaurant(id: UUID(), name: "Subway", description: "This is a test for the view. *Insert Name* makes garbage food that tastes absolutely amazing. Hands-down the best fastfood joint you can go to!", openHour: 6, openMinute: 0, closeHour: 22, closeMinute: 30, latitude: 32.879224, longitude: -117.235913, waitTime: 12)]

}

