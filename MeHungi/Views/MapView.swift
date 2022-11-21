//
//  MapView.swift
//  MeHungi
//
//  Created by Aaron McCully on 11/3/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    let model: ModelData
    @StateObject var locationManager = LocationManager()
    
    // view will respond when changes are made to @State vars
    @State var search: String = ""

    var body: some View {
        // create navigation stack here!
        ZStack {
            // anotationItems with search feature: search != "" ? model.restaurants.filter { restaurant in restaurant.name.lowercased().contains(search.lowercased())} : model.restaurants
            Map(coordinateRegion: $locationManager.mapRegion, showsUserLocation: true, annotationItems: search != "" ? model.restaurants.filter { restaurant in restaurant.name.lowercased().contains(search.lowercased())} : model.restaurants) { restaurant in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)) {

                    PlaceAnnotationView(restaurant: restaurant)
                }
            }
            .edgesIgnoringSafeArea(.top)
            //.accentColor(Color(.systemPurple))
            .onAppear {
                locationManager.checkIfLocationServicesIsEnabled()
            }
            
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Search...", text: $search)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(.thinMaterial).padding(8))
                
                Spacer()
            }
        }
        
    }
    
    struct PlaceAnnotationView: View {
        @State private var showingSheet = false
        @State var selectedDetent: PresentationDetent = .fraction(0.25)

        let restaurant: Restaurant

        var body: some View {
            VStack(spacing: 0) {
                Text(restaurant.name)
                    .foregroundColor(.red)
                Image(systemName: "mappin.circle.fill")
                    .font(.title)
                    .foregroundColor(.red)
            }
            .onTapGesture {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                VStack(alignment: .leading) {
                    Button(action: {
                        showingSheet.toggle()
                    }, label: {
                        if selectedDetent != .fraction(0.25) {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                                .font(.largeTitle)
                                .padding(30)
                        }
                        else {
                            Spacer()
                        }
                    })
                    RestaurantDetailView(restaurant: restaurant)
                        .foregroundColor(.primary)
                }
                // removed .middle
                .presentationDetents([.fraction(0.25), .large], selection: $selectedDetent)
            }
        }
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(model: ModelData())
    }
}
