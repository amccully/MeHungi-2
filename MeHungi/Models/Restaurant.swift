//
//  Restaurant.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/27/22.
//

import Foundation

class Restaurant: Decodable, Identifiable, ObservableObject {
    
    enum CodingKeys: CodingKey {
        case name, waitTime, description, operatingHours, isOpen
    }
    
    let id: UUID = UUID()
    let name: String
    let description: String
    let operatingHours: String
    @Published var isOpen: Bool
    @Published var waitTime: Int
    
    init(name: String, description: String, operatingHours: String, isOpen: Bool, waitTime: Int) {
        self.name = name
        self.description = description
        self.operatingHours = operatingHours
        self.isOpen = isOpen
        self.waitTime = waitTime
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        waitTime = try container.decode(Int.self, forKey: .waitTime)
        description = try container.decode(String.self, forKey: .description)
        operatingHours = try container.decode(String.self, forKey: .operatingHours)
        isOpen = try container.decode(Bool.self, forKey: .isOpen)
    }
}
