//
//  RestaurantDetailView.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/30/22.
//

import SwiftUI

struct RestaurantDetailView: View {
    var restaurant: Restaurant
    
    var body: some View {
        VStack(spacing: 10) {
            Text(restaurant.name)
                .font(.system(size: 40))
                .bold()
            HStack {
                Text(restaurant.openIntervalString)
                    .padding(.trailing, 5)
                    
                if(restaurant.isOpen) {
                    Text("Open")
                        .foregroundColor(Color.green)
                    Image(systemName: "timer")
                        .padding(.leading, 5)
                    Text("\(restaurant.waitTime) mins")
                }
                else {
                    Text("Closed")
                        .foregroundColor(Color.red)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color.orange.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(restaurant.description)
                .padding(.horizontal, 10)
            Spacer()
        }
        //.navigationTitle(restaurant.name)
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(restaurant: Restaurant(id: UUID(), name: "McDonalds", description: "This is a test for the view. Mcdonalds makes garbage food that tastes absolutely amazing. Hands-down the best fastfood joint you can go to!", openHour: 6, openMinute: 0, closeHour: 23, closeMinute: 30, latitude: 32.879224, longitude: -117.235913, waitTime: 12))
    }
}
