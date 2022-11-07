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
        NavigationView {
            Map(coordinateRegion: $mapRegion, annotationItems: model.restaurants) { restaurantObj in
                // here, change mapmarker to a map annotation that shows basic info and allows the user to transition to the restaurant detail view
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: restaurantObj.latitude, longitude: restaurantObj.longitude)) {
                    // how do I make navigationTitle larger on destination?
                    NavigationLink {
                        RestaurantDetailView(restaurant: restaurantObj)
                    } label: {
                        //PlaceAnnotationView(restaurant: restaurantObj)
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
        
    }
    
    struct PlaceAnnotationView: View {
      @State private var showTitle = true
      
      let restaurant: Restaurant
      
      var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text(restaurant.name)
                    .foregroundColor(Color(.black))
                Text("\(restaurant.waitTime) mins")
                    .foregroundColor(Color(.black))
            }
            .padding()
            .background(Color(.white))
            .cornerRadius(20)
            .opacity(showTitle ? 0 : 1)

          Image(systemName: "mappin.circle.fill")
            .font(.title)
            .foregroundColor(.red)
          
          Image(systemName: "arrowtriangle.down.fill")
            .font(.caption)
            .foregroundColor(.red)
            .offset(x: 0, y: -5)
        }
        .onTapGesture {
          withAnimation(.easeInOut) {
            showTitle.toggle()
          }
        }
      }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView().environmentObject(ModelData())
    }
}
