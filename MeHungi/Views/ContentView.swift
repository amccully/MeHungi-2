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
        }
    }
    
    func loadData() async {
        
        model.restaurants = [
            Restaurant(name: "Subway", description: "", operatingHours: "", isOpen: true, waitTime: 15),
            Restaurant(name: "Panda", description: "", operatingHours: "", isOpen: true, waitTime: 3),
            Restaurant(name: "Burger King", description: "", operatingHours: "", isOpen: true, waitTime: 0),
            Restaurant(name: "Triton Grill", description: "", operatingHours: "", isOpen: true, waitTime: 35)
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
