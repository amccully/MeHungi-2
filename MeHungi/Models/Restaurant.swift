//
//  Restaurant.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/27/22.
//

import Foundation

class Restaurant: Decodable, Identifiable, ObservableObject {
    enum CodingKeys: CodingKey {
        case name, waitTime
    }
    
    let id: UUID = UUID()
    let name: String
    @Published var waitTime: Int
    
    init(name: String, waitTime: Int) {
        self.name = name
        self.waitTime = waitTime
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        waitTime = try container.decode(Int.self, forKey: .waitTime)
    }
}
