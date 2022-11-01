//
//  RestaurantDetailView.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/30/22.
//

import SwiftUI

struct RestaurantDetailView: View {
    @StateObject var restaurant: Restaurant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(restaurant.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            HStack {
                Text(restaurant.operatingHours)
                    .padding(.trailing)
                    
                if(restaurant.isOpen) {
                    Text("Open")
                        .foregroundColor(Color.green)
                    Image(systemName: "timer")
                        .padding(.leading)
                    Text("\(restaurant.waitTime) mins")
                }
                else {
                    Text("Closed")
                        .foregroundColor(Color.red)
                }
            }
            Text(restaurant.description)
        }
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(restaurant: Restaurant(name: "Mcdonalds", description: "This is a test for the view. Mcdonalds makes garbage food that tastes absolutely amazing. Hands-down the best fastfood joint you can go to!", operatingHours: "6am - 12pm", isOpen: true, waitTime: 12))
    }
}
