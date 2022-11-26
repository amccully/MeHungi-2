//
//  Coordinates.swift
//  MeHungi
//
//  Created by Aaron McCully on 11/24/22.
//

import Foundation
import MapKit

class Coordinates: ObservableObject {
    public static let sharedCoords = Coordinates()
    @Published var region: MKCoordinateRegion
    
    init() {
        self.region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 32.879765,
            longitude: -117.236202),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01)
    )
    }
}
