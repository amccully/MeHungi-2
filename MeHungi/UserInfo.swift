//
//  UserInfo.swift
//  MeHungi
//
//  Created by Aaron McCully on 11/24/22.
//
// Test coords 1: 32.881977, -117.235209

import Foundation
import MapKit

class UserInfo: ObservableObject {
    // was let for shareCoords?
    public static var sharedCoords = UserInfo()
    public static var searchType = "Convenience"
    public static let searchTypes = ["Convenience", "Wait Time", "Distance Away"]
    
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
