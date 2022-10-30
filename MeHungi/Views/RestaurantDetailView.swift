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
        Text(restaurant.name)
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(restaurant: Restaurant(name: "Mcdonalds", waitTime: 12))
    }
}
