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
    
    @State var search: String = ""
    
    @State private var mapRegion = MKCoordinateRegion(
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
            NavigationView {
                Map(coordinateRegion: $mapRegion, annotationItems: search != "" ? model.restaurants.filter { restaurant in restaurant.name.lowercased().contains(search.lowercased())} : model.restaurants) { restaurant in
                    // here, change mapmarker to a map annotation that shows basic info and allows the user to transition to the restaurant detail view
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)) {
                        // how do I make navigationTitle larger on destination?
                        NavigationLink {
                            RestaurantDetailView(restaurant: restaurant)
                        } label: {
                            PlaceAnnotationView(restaurant: restaurant)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
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
    
//    struct PlaceAnnotationView: View {
//      @State private var showTitle = true
//
//      let restaurant: Restaurant
//
//      var body: some View {
//        VStack(spacing: 0) {
//            VStack {
//                Text(restaurant.name)
//                    .foregroundColor(Color(.black))
//                Text("\(restaurant.waitTime) mins")
//                    .foregroundColor(Color(.black))
//            }
//            .padding()
//            .background(Color(.white))
//            .cornerRadius(20)
//            .opacity(showTitle ? 0 : 1)
//
//          Image(systemName: "mappin.circle.fill")
//            .font(.title)
//            .foregroundColor(.red)
//
//          Image(systemName: "arrowtriangle.down.fill")
//            .font(.caption)
//            .foregroundColor(.red)
//            .offset(x: 0, y: -5)
//        }
//        .onTapGesture {
//          withAnimation(.easeInOut) {
//            showTitle.toggle()
//          }
//        }
//      }
//    }
    
    struct PlaceAnnotationView: View {
        @State private var showingSheet = false

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
                // change this to drag gesture later?
                VStack(alignment: .leading) {
                    Button(action: {
                        showingSheet.toggle()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .font(.largeTitle)
                            .padding(20)
                    })
                    RestaurantDetailView(restaurant: restaurant)
                        .foregroundColor(.primary)
                }
                .presentationDetents([.fraction(0.25), .medium, .large])
            }
        }
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(model: ModelData())
    }
}
