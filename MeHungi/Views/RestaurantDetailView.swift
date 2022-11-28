//
//  RestaurantDetailView.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/30/22.
//

import SwiftUI

struct RestaurantDetailView: View {
    @EnvironmentObject var model: ModelData
    
    let id: String
    
    @State var error: Bool = false
    
    var restaurant: Restaurant {
        model.restaurants[id]!
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text(restaurant.name)
                    .font(.system(size: 40))
                    .bold()
                HStack {
                    
                    Text(restaurant.openIntervalString)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.thinMaterial))
                    
                    Text(restaurant.isOpen ? "Open" : "Closed")
                        .foregroundColor(restaurant.isOpen ? .green : .red)
                        .bold()
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.thinMaterial))
                    
                    if restaurant.isOpen {
                        HStack {
                            Image(systemName: "timer")
                                .padding(.leading, 5)
                            Text("\(restaurant.waitTime) mins")
                        }
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.thinMaterial))
                        .foregroundColor(restaurant.waitTime <= 10 ? .green : restaurant.waitTime <= 30 ? .orange : .red)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                
                HStack {
                    let distanceAsString = (restaurant.distanceAway < 0.05) ? "< 0.1" : String(format: "%0.1f", restaurant.distanceAway)
                    Text("\(distanceAsString) mi")
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.thinMaterial))
                }
                
                Divider()
                // make this pop more

                Text(restaurant.description)
                    .padding(.horizontal, 10)
                
                Divider()
                
                NavigationLink {
                    OrderView(id: restaurant.id).environmentObject(model)
                } label: {
                    Text("Order Form")
                        .foregroundColor(Color.white)
                        .font(.title2)
                        .bold()
                }
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.orange)
                        .shadow(color: .black, radius: 1)
                )
                Button {
                    let mapUrl = URL(string: "maps://?saddr=&daddr=\(restaurant.latitude),\(restaurant.longitude)")
                    if UIApplication.shared.canOpenURL(mapUrl!) {
                        UIApplication.shared.open(mapUrl!, options: [:], completionHandler: nil)
                    }
                } label: {
                    Text("Get Directions")
                        .foregroundColor(Color.white)
                        .font(.title2)
                        .bold()
                }
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.blue)
                        .shadow(color: .black, radius: 1)
                )
                
                Spacer()
                
            }
            //.navigationTitle(restaurant.name)
        }
        .refreshable {
            Task {
                do {
                    model.restaurants[id] = try await Restaurant(id: id, model: model)
                } catch {
                    self.error = true
                }
            }
        }
        .alert("Error", isPresented: $error) {
            Button("OK", role: .cancel) { }
        }
    }
}

// ???
//struct RestaurantDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantDetailView(restaurant: Restaurant(id: "001", name: "Subway", description: "This is a test for the view. *Insert Name* makes garbage food that tastes absolutely amazing. Hands-down the best fastfood joint you can go to!", openHour: 6, openMinute: 0, closeHour: 2, closeMinute: 00, latitude: 32.881398208652115, longitude: -117.23520934672317, waitTime: 12), id: "001")
//    }
//}
