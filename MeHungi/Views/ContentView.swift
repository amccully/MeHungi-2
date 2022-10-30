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
            Restaurant(name: "Subway", waitTime: 30),
            Restaurant(name: "Panda", waitTime: 5),
            Restaurant(name: "Burger King", waitTime: 0),
            Restaurant(name: "Santorini's", waitTime: 3)
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
