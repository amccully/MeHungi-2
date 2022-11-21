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
    
    // view will respond when changes are made to @State vars
    @State var search: String = ""
    
    var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 32.879687,
            longitude: -117.233627),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01)
    )

    var body: some View {
//        Map(coordinateRegion: $mapRegion)
//            .edgesIgnoringSafeArea(.top)
        // create navigation stack here!
        ZStack {
            // anotationItems with search feature: search != "" ? model.restaurants.filter { restaurant in restaurant.name.lowercased().contains(search.lowercased())} : model.restaurants
            Map(coordinateRegion: Binding(get: { self.mapRegion }, set: { newValue in }), annotationItems: search != "" ? model.restaurants.filter { restaurant in restaurant.name.lowercased().contains(search.lowercased())} : model.restaurants) { restaurant in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)) {
                    // how do I make navigationTitle larger on destination?

                    PlaceAnnotationView(restaurant: restaurant)

                }
            }
            .edgesIgnoringSafeArea(.top)
            
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
                
//                Image(systemName: "arrowtriangle.down.fill")
//                    .font(.caption)
//                    .foregroundColor(.red)
//                    .offset(x: 0, y: -5)
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
