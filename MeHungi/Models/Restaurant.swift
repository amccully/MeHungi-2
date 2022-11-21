//
//  Restaurant.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/27/22.
//

import Foundation

class Restaurant: Decodable, Identifiable, Comparable {
    
   /* let id: String
    let name: String
    let description: String
    let openHour: Int
    let openMinute: Int
    let closeHour: Int
    let closeMinute: Int
    let latitude: Double
    let longitude: Double
    */
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
    }

   /* init(id: String) {
        self.id = id
    }
*/
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
        var rightDist = lhs.distance
        
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
    /*
    func reload()  async {
        let url = URL(string: "http://127.0.0.1:5000//restaurant/" + id)

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in 
   

        if let error = error {
            print("Error accessing url: \(error)")
            return
        }

        /* if response var is a valid HTTTPURL response, go into guard, if response is a success,
         continue to rest of code, else throw error and return
        */
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(response)")
            return
         }

        // try to decode JSON file, if error print "whoops"
        do {
            let restaurants = try JSONDecoder().decode(restaurants.self, from: data)
        }
        catch {
            print("Whoops!")
        }
    

    })

    task.resume()

    }

    */
    
}
