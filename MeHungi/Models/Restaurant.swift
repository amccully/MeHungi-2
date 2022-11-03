//
//  Restaurant.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/27/22.
//

import Foundation

class Restaurant: Decodable, Identifiable {
    
    let id: UUID
    let name: String
    let description: String
    let openHour: Int
    let openMinute: Int
    let closeHour: Int
    let closeMinute: Int
    let latitude: Double
    let longitude: Double
    var waitTime: Int
    
    var isOpen: Bool {
        let now = Date()
        // ! means optional: promises program that the values will be valid (not nil)
        // ?? means nil-coelescing: can act as fail-safe
        let open = Calendar.current.date(bySettingHour: openHour, minute: openMinute, second: 0, of: now)!
        let close = Calendar.current.date(bySettingHour: closeHour, minute: closeMinute, second: 0, of: now)!
        // fix interval, for hour 0, we are saying that we are in the next day now, not the current day
        // find out how to make an interval across two days?
        let interval = DateInterval(start: open, end: close)
        return interval.contains(now)
    }
    
    var openIntervalString: String {
        "\(openHour % 12):\(String(format: "%02d", openMinute)) \(openHour > 12 ? "PM" : "AM") - \(closeHour % 12):\(String(format: "%02d", closeMinute)) \(closeHour > 12 ? "PM" : "AM")"
    }
    
    init(id: UUID, name: String, description: String, openHour: Int, openMinute: Int, closeHour: Int, closeMinute: Int, latitude: Double, longitude: Double, waitTime: Int) {
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
    }
}
