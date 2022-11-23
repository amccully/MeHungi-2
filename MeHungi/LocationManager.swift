//
//  LocationManager.swift
//  MeHungi
//
//  Created by Aaron McCully on 11/17/22.
//
//  32.881977
// -117.235209

import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    var authorized: Bool = false
    
    @Published var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 32.879765,
            longitude: -117.236202),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01)
    )
    
    func checkIfLocationServicesIsEnabled() {
        // wtf lol
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            // locationManager.activityType for adjusting what the users transport mode is?
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self
        }
        else {
            print("Alert in locationServicesIsEnabled")
        }
    }
    
    var location: CLLocationCoordinate2D? {
        checkLocationAuthorization()
        if authorized {
            return locationManager?.location?.coordinate
        }
        return nil
    }
    
    private func checkLocationAuthorization() {
        authorized = false
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted.")
        case .denied:
            print("You have denied this app from location permissions.")
        case .authorizedAlways, .authorizedWhenInUse:
            authorized = true
            // move later
            mapRegion = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                           span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
