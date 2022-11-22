//
//  Restaurant.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/27/22.
//
import Foundation

enum RestaurantError: Error {
    case HTTPRequestError
}

class Restaurant: Decodable, Identifiable, Comparable {
    var id: String
    var name: String
    var description: String
    var openHour: Int
    var openMinute: Int
    var closeHour: Int
    var closeMinute: Int
    var latitude: Double
    var longitude: Double
    var distanceAway: Double
    
    // congestion
    
    var waitTime: Int

    var isOpen: Bool {
        if(openHour == closeHour && openMinute == closeMinute) {
            return true
        }
        
        // ! means optional: promises program that the values will be valid (not nil)
        // ?? means nil-coelescing: can act as fail-safe
        // for safe-keeping: (closeHour < openHour) ? Calendar.current.date(byAdding: .day, value: 1, to: now)!
        // perfect now!
        let now = Date()
        let open = Calendar.current.date(bySettingHour: openHour, minute: openMinute, second: 0, of: now)!
        let close = Calendar.current.date(bySettingHour: closeHour, minute: closeMinute, second: 0, of: now)!
        return closeHour < openHour || (closeHour == openHour && closeMinute < openMinute) ? !DateInterval(start: close, end: open).contains(now) : DateInterval(start: open, end: close).contains(now)
    }
    
    var openIntervalString: String {
        if openHour == closeHour && openMinute == closeMinute {
            return "Open 24 hours"
        }
        return "\(openHour % 12 == 0 ? 12 : openHour % 12):\(String(format: "%02d", openMinute)) \(openHour > 11 ? "PM" : "AM") - \(closeHour % 12 == 0 ? 12 : closeHour % 12):\(String(format: "%02d", closeMinute)) \(closeHour > 11 ? "PM" : "AM")"
    }
    
    init(id: String, name: String, description: String, openHour: Int, openMinute: Int, closeHour: Int, closeMinute: Int, latitude: Double, longitude: Double, waitTime: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.openHour = openHour
        self.openMinute = openMinute
        self.closeHour = closeHour
        self.closeMinute = closeMinute
        self.latitude = latitude
        self.longitude = longitude
        self.waitTime = waitTime
        self.distanceAway = 0.0
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case description
        case openHour
        case openMinute
        case closeHour
        case closeMinute
        case latitude
        case longitude
        case waitTime
        case distanceAway
    }
    
    static func reload(id: String) async throws -> Restaurant {
        let url: URL = URL(string: "http://127.0.0.1:5000//restaurant/\(id)")!

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw RestaurantError.HTTPRequestError
        }

        return try JSONDecoder().decode(Restaurant.self, from: data)
    }
    
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: Restaurant, rhs: Restaurant) -> Bool {
        lhs.id < rhs.id
    }
    
    func setDistanceAway(_distanceAway: Double) {
        self.distanceAway = _distanceAway
    }
    
}
