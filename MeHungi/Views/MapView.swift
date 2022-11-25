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
    
    // Vars for moving between map annotations
    // used for keeping track of which map annotation item to transition to
    var counter: Int = 0
    
    var body: some View {
        // create navigation stack here!
        ZStack {
            // Binding(get: { model.locationManager.mapRegion }, set: { _ in })
            Map(coordinateRegion: $model.locationManager.mapRegion, showsUserLocation: true, annotationItems: search != "" ? model.restaurants.values.sorted().filter { restaurant in restaurant.name.lowercased().contains(search.lowercased())} : model.restaurants.values.sorted()) { restaurant in
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
                
                HStack {
                    Button(action: {
                        withAnimation {
//                            model.locationManager.mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 32.88076184401626, longitude: -117.2430254489795), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//                            model.locationManager.objectWillChange.send()
                            //model.restaurants.values.sorted()[0]
                        }
                    }, label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color.white)
                            .font(.title)
                        Text("Prev")
                            .foregroundColor(Color.white)
                            .font(.title)
                    })
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.pink)
                            .shadow(color: .pink, radius: 2)
                    )
                    Spacer()
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            Text("Next")
                                .font(.title)
                                .foregroundColor(Color.white)
                            Image(systemName: "arrow.forward")
                                .foregroundColor(Color.white)
                                .font(.title)
                        })
                    }
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.pink)
                            .shadow(color: .pink, radius: 2)
                    )
                }
                .padding(20)
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
