//
//  MapView.swift
//  MeHungi
//
//  Created by Aaron McCully on 11/3/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var model: ModelData = ModelData()
    
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
        Map(coordinateRegion: $mapRegion, annotationItems: model.restaurants) { restaurantObj in
            // here, change mapmarker to a map annotation that shows basic info and allows the user to transition to the restaurant detail view
            MapMarker(coordinate: CLLocationCoordinate2D(latitude: restaurantObj.latitude, longitude: restaurantObj.longitude))
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
