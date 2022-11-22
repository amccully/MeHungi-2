import Foundation

enum RestaurantError: Error {
    case invalidServerResponse
}

/*
 
 {"restaurant": {"id": self.id, "name": self.name, "description": self.description,
          "open hour": self.openHour, "open minute": self.openMinute, "close hour": self.closeHour,
          "close minute": self.closeMinute, "latitude": self.latitude, "longitude": self.longitude}}
 
 */

struct RestOuterStruct: Codable {
    var restaurant: RestInnerStruct
}

struct RestInnerStruct: Codable {
    var id: String
    var name: String
    var description: String
    var openHour: Int
    var openMinute: Int
    var closeHour: Int
    var closeMinute: Int
    var latitude: Float
    var longitude: Float
    var waitTime: Int
}

class Restaurant: Decodable, Identifiable, Comparable {
    
    var id: String
    var name: String
    var description: String
    var openHour: Int
    var openMinute: Int
    var closeHour: Int
    var closeMinute: Int
    var latitude: Float
    var longitude: Float
    
    // congestion
    
    var waitTime = 0
    var distance = 0.0
    
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
    
   /* init(id: String, name: String, description: String, openHour: Int, openMinute: Int, closeHour: Int, closeMinute: Int, latitude: Double, longitude: Double, waitTime: Int) {
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
*/
    init(id: String) {
        self.id = id
        reload() // async call in function does not support concurrency and need to catch error
    }

    static func ==(lhs: Restaurant, rhs: Restaurant) -> Bool{
        // all member variables the same or just id?
        return lhs.id == rhs.id /*&&
        lhs.name == rhs.name &&
        lhs.description == rhs.description &&
        lhs.openHour == rhs.openHour &&
        lhs.openMinute == rhs.openMinute &&
        lhs.closeHour == rhs.closeHour &&
        lhs.closeMinute == rhs.closeMinute &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude &&
        lhs.waitTime == rhs.waitTime
        */
    }
    
    static func <(lhs: Restaurant, rhs: Restaurant) -> Bool {
        var leftDist = lhs.distance
        var rightDist = rhs.distance
        
        //if same distance, wait time matters
        if (leftDist == rightDist) {
            return lhs.waitTime < rhs.waitTime
        }
        // if one is loser than 0.1, return that one
        if ((leftDist <= 0.1 && rightDist > 0.1) || (rightDist <= 0.1 && leftDist > 0.1)) {
            return leftDist < rightDist;
        }
        leftDist = floor(leftDist*4)
        rightDist = floor(4*rightDist)
        
        // if one is more than .25 away, return smaller one
        if (leftDist != rightDist){
            return leftDist < rightDist;
        }
        // return smaller wait time
        return lhs.waitTime < rhs.waitTime;
        
    }
    
    func reload() async throws {
        let url: URL = URL(string: "http://127.0.0.1:5000//restaurant/" + self.id)!

        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 22 else {
            
            throw RestaurantError.invalidServerResponse
        }

        let miniRest = try JSONDecoder().decode(RestOuterStruct.self, from: data)
        
        let innerRest = miniRest.restaurant
        
        // update inner values
        self.name = innerRest.name
        self.description = innerRest.description
        self.openHour = innerRest.openHour
        self.openMinute = innerRest.openMinute
        self.closeHour = innerRest.closeHour
        self.closeMinute = innerRest.closeMinute
        self.latitude = innerRest.latitude
        self.longitude = innerRest.longitude
        self.waitTime = innerRest.waitTime
    }

    
    
}
