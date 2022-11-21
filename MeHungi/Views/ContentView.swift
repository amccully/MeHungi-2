//
//  ContentView.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/27/22.
//

import SwiftUI
import CoreLocationUI

struct ContentView: View {
    
    @StateObject var model: ModelData = ModelData()
    
    @State private var showingSheet = false
    @State var byFoot = true
    @State var search: String = ""
    
    @State private var transportMode = "byFoot"
    @State private var searchType = "Wait Time"
    var transportTypes = ["byFoot", "byBike"]
    var searchTypes = ["Wait Time", "Distance Away"]
    
    var body: some View {
        TabView {
            NavigationView {
                List {
                    Section {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.secondary)
                            // change to allow user to choose what they search by (name, wait time, finish by, etc)
                            TextField("Search...", text: $search)
                            Button(action: {
                                showingSheet.toggle()
                            }, label: {
                                Image(systemName: "gearshape.fill")
                                    .foregroundColor(.gray)
                                    .font(.title)
                            })
                            .sheet(isPresented: $showingSheet) {
                                List {
                                    Button(action: {
                                        showingSheet.toggle()
                                    }, label: {
                                        HStack {
                                            Image(systemName: "xmark.circle")
                                                .foregroundColor(.red)
                                                .font(.largeTitle)
                                            Text("Close")
                                                .foregroundColor(.red)
                                        }
                                    })
                                    Section {
                                        Picker("Sort by...", selection: $searchType) {
                                            ForEach(searchTypes, id: \.self) {
                                                Text($0)
                                            }
                                        }
                                        .pickerStyle(.menu)
                                    }
                                    VStack(alignment: .leading) {
                                        Text("Mode of Transport:")
                                            .padding(.vertical, 5)
                                        HStack {
                                            Image(systemName: "figure.walk")
                                                .font(.largeTitle)
                                                .padding(.horizontal, 62)
                                            Image(systemName: "bicycle")
                                                .font(.largeTitle)
                                                .padding(.horizontal, 42)
                                        }
                                        Picker("Transport", selection: $transportMode) {
                                            ForEach(transportTypes, id: \.self) {
                                                Text($0)
                                            }
                                        }
                                        .pickerStyle(.segmented)
//                                                Text("Mode of Transportation:")
//                                                Spacer()
//                                                Image(systemName: "bicycle")
//                                                    .font(.largeTitle)
//                                                Toggle("Mode of Transport", isOn: $byFoot)
//                                                    .labelsHidden()
//                                                Image(systemName: "figure.walk")
//                                                    .font(.largeTitle)
                                    }
                                    
                                }
                                
                            }
                        }
                    }
                    Section {
                        let filtered = search != "" ? model.restaurants.filter { restaurant in restaurant.name.lowercased().contains(search.lowercased())} : model.restaurants
                        let sortWaitTime = filtered.sorted(by: { $0.waitTime < $1.waitTime })
                        // just a test for now
                        let sortDistanceAway = filtered.sorted(by: { $0.name < $1.name })
                        ForEach(searchType == "Wait Time" ? sortWaitTime : sortDistanceAway) { restaurant in
                            NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                                
                                HStack {
                                    Text(restaurant.name)
                                    Spacer()
                                    Text("\(restaurant.waitTime) mins")
                                }
                            }
                        }
                    }
                    if let location = LocationManager.shared.location {
                        Text("Your location: \(location.latitude), \(location.longitude)")
                    }
                    LocationButton {
                        LocationManager.shared.requestLocation()
                    }
                }
                .animation(.default, value: search)
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
            
            MapView(model: model)
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
    
    func loadData() async {
        
        model.restaurants = [
            Restaurant(id: UUID(), name: "Subway", description: "This is a test for the view. *Insert Name* makes garbage food that tastes absolutely amazing. Hands-down the best fastfood joint you can go to!", openHour: 6, openMinute: 0, closeHour: 2, closeMinute: 00, latitude: 32.879224, longitude: -117.235913, waitTime: 12),
            Restaurant(id: UUID(), name: "Panda", description: "This is a test for the view. *Insert Name* makes garbage food that tastes absolutely amazing. Hands-down the best fastfood joint you can go to!", openHour: 9, openMinute: 50, closeHour: 12, closeMinute: 30, latitude: 32.884638, longitude: -117.239104, waitTime: 3),
            Restaurant(id: UUID(), name: "Burger King", description: "This is a test for the view. *Insert name* makes garbage food that tastes absolutely amazing. Hands-down the best fastfood joint you can go to!", openHour: 6, openMinute: 30, closeHour: 0, closeMinute: 0, latitude: 32.879224, longitude: -117.235913, waitTime: 16),
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
