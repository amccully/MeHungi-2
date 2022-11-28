//
//  ContentView.swift
//  MeHungi
//
//  Created by Aaron McCully on 10/27/22.
//
import SwiftUI
import CoreLocationUI
import CoreLocation

enum HTTPErrors: Error {
    case HTTPRequestError
}

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
                                    }
                                    
                                }
                                
                            }
                        }
                    }
                    Section {
                        let filtered = search != "" ? model.restaurants.values.sorted().filter { restaurant in restaurant.name.lowercased().contains(search.lowercased())} : model.restaurants.values.sorted()
                        let sortWaitTime = filtered.sorted(by: { $0.waitTime < $1.waitTime })
                        // just a test for now
                        let sortDistanceAway = filtered.sorted(by: { $0.name < $1.name })
                        ForEach(searchType == "Wait Time" ? sortWaitTime : sortDistanceAway) { restaurant in
                            NavigationLink(destination: RestaurantDetailView(id: restaurant.id).environmentObject(model)) {
                                
                                HStack {
                                    Text(restaurant.name)
                                    Spacer()
                                    Text("\(restaurant.waitTime) mins")
                                }
                            }
                        }
                    }
//                    if let location = LocationManager.shared.location {
//                        Text("Your location: \(location.latitude), \(location.longitude)")
//                    }
//                    LocationButton {
//                        LocationManager.shared.requestLocation()
//                    }
                }
                .animation(.default, value: search)
                .navigationTitle("MeHungi")
                .task {
                    model.locationManager.checkIfLocationServicesIsEnabled()
                    await loadData()
                }
                .refreshable {
                    Task {
                        model.locationManager.checkIfLocationServicesIsEnabled()
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
            "001": Restaurant(id: "001", name: "Subway", description: "This is a test for the view. *Insert Name* makes garbage food that tastes absolutely amazing. Hands-down the best fastfood joint you can go to!", openHour: 6, openMinute: 0, closeHour: 2, closeMinute: 00, latitude: 32.881398208652115, longitude: -117.23520934672317, waitTime: 12, menuItems: ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
            "002": Restaurant(id: "002", name: "Panda Express", description: "This is a test for the view. *Insert Name* makes garbage food that tastes absolutely amazing. Hands-down the best fastfood joint you can go to!", openHour: 9, openMinute: 50, closeHour: 12, closeMinute: 30, latitude: 32.884638, longitude: -117.239104, waitTime: 3, menuItems: ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
            "003": Restaurant(id: "003", name: "Burger King", description: "This is a test for the view. *Insert name* makes garbage food that tastes absolutely amazing. Hands-down the best fastfood joint you can go to!", openHour: 6, openMinute: 30, closeHour: 0, closeMinute: 0, latitude: 32.8809679784332, longitude: -117.23547474701675, waitTime: 16, menuItems: ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"]),
            "004": Restaurant(id: "004", name: "Triton Grill", description: "This is a test for the view. *Insert Name* makes garbage food that tastes absolutely amazing. Hands-down the best fastfood joint you can go to!", openHour: 1, openMinute: 26, closeHour: 1, closeMinute: 25, latitude: 32.88076184401626, longitude: -117.2430254489795, waitTime: 26, menuItems: ["Food 1", "Food 2", "Food 3", "Food 4", "Food 5"])
        ]

        // start point of possibly fucked code
//        let url: URL = URL(string: "http://127.0.0.1:5000/IDs")!
//
//        var list_ids: [String] = []
//        do {
//            let (data, response) = try await URLSession.shared.data(from: url)
//
//            guard let httpResponse = response as? HTTPURLResponse,
//                  httpResponse.statusCode == 200 else {
//                throw RestaurantError.HTTPRequestError
//
//            }
//
//            let dic_ids = try JSONDecoder().decode([String:[String]].self, from: data)
//            list_ids = dic_ids["ids"]!
//            for id in list_ids {
//                model.restaurants[id] = try await Restaurant(id: id, model: model)
//            }
//
//        }
//        catch {
//            print("WHOOOPS")
//            print("Error is \(error)")
//            model.restaurants = [:]
//        }
        // end point
        
        // getting user coordinates as a CLLocation
        if let unwrappedLocation = model.locationManager.location {
            let userCoords = CLLocation(latitude: unwrappedLocation.latitude,
                                        longitude: unwrappedLocation.longitude)
            // settings restaurant distances
            model.restaurants.values.sorted().forEach { restaurant in
                let distance = (userCoords.distance(from: CLLocation(latitude: restaurant.latitude, longitude: restaurant.longitude)) / 1000) * 0.621371
                restaurant.setDistanceAway(_distanceAway: distance)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
