//
//  ContentView.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/27/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model: ModelData = ModelData()
    
    var body: some View {
        TabView {
            NavigationView {
                List(model.restaurants) { restaurant in
                    NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                        HStack {
                            Text(restaurant.name)
                            Spacer()
                            Text("\(restaurant.waitTime) mins")
                        }
                    }
                }
                .navigationTitle("MeHungi")
                .task {
                    await loadData()
                }
                .refreshable {
                    Task {
                        await loadData()
                    }
                }
            }.tabItem {
                Label("List", systemImage: "list.bullet")
            }
            
            MapView()
                .environmentObject(model)
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
    
    func loadData() async {
        
        model.restaurants = [
            Restaurant(id: UUID(), name: "Subway", description: "This is a test for the view. *Insert Name* makes garbage food that tastes absolutely amazing. Hands-down the best fastfood joint you can go to!", openHour: 6, openMinute: 0, closeHour: 2, closeMinute: 00, latitude: 32.879224, longitude: -117.235913, waitTime: 12),
            Restaurant(id: UUID(), name: "Panda", description: "This is a test for the view. *Insert Name* makes garbage food that tastes absolutely amazing. Hands-down the best fastfood joint you can go to!", openHour: 11, openMinute: 0, closeHour: 12, closeMinute: 30, latitude: 32.884638, longitude: -117.239104, waitTime: 3),
            Restaurant(id: UUID(), name: "Burger King", description: "This is a test for the view. *Insert name* makes garbage food that tastes absolutely amazing. Hands-down the best fastfood joint you can go to!", openHour: 6, openMinute: 30, closeHour: 0, closeMinute: 0, latitude: 32.879224, longitude: -117.235913, waitTime: 0),
            Restaurant(id: UUID(), name: "Triton Grill", description: "This is a test for the view. *Insert Name* makes garbage food that tastes absolutely amazing. Hands-down the best fastfood joint you can go to!", openHour: 1, openMinute: 26, closeHour: 1, closeMinute: 25, latitude: 32.879224, longitude: -117.235913, waitTime: 26)
        ]
        
        /*
             guard let url = URL(string: "https://myurlhere.com") else {
                 print("Invalid URL")
                 return
             }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                if let decodedResponse = try? JSONDecoder().decode(???.self, from: data) {
                    ??? = decodedResponse.???
                }
            } catch {
                print("Invalid data")
            }
        */
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
