//
//  MapView.swift
//  MeHungi
//
//  Created by Aaron McCully on 11/3/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var model: ModelData
    
    // view will respond when changes are made to @State vars
    @State var search: String = ""

    var body: some View {
        // create navigation stack here!
        ZStack {
            // anotationItems with search feature: search != "" ? model.restaurants.filter { restaurant in restaurant.name.lowercased().contains(search.lowercased())} : model.restaurants
            Map(coordinateRegion: Binding(get: { model.locationManager.mapRegion }, set: { _ in }), showsUserLocation: true, annotationItems: search != "" ? model.restaurants.values.sorted().filter { restaurant in restaurant.name.lowercased().contains(search.lowercased())} : model.restaurants.values.sorted()) { restaurant in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)) {

                    PlaceAnnotationView(restaurant: restaurant)
                        .environmentObject(model)
                }
            }
            .edgesIgnoringSafeArea(.top)
            //.accentColor(Color(.systemPurple))
            .onAppear {
                model.locationManager.checkIfLocationServicesIsEnabled()
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
        @EnvironmentObject var model: ModelData
        
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
                    RestaurantDetailView(id: restaurant.id)
                        .environmentObject(model)
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
        MapView()
            .environmentObject(ModelData())
    }
}
