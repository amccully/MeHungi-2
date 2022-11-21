//
//  LocationManager.swift
//  MeHungi
//
//  Created by Aaron McCully on 11/17/22.
//
//  32.881977
// -117.235209

import CoreLocation

let locationManager = LocationManager()

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
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
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted.")
        case .denied:
            print("You have denied this app from location permissions.")
        case .authorizedAlways, .authorizedWhenInUse:
            // temporary
            break
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//
//    let manager = CLLocationManager()
//    static let shared = LocationManager()
//
//    @Published var location: CLLocationCoordinate2D?
//
//    override init() {
//        super.init()
//        manager.delegate = self
//    }
//
//    func requestLocation() {
//        //manager.requestLocation()
//        manager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        location = locations.first?.coordinate
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Whoops!")
//    }
//
//}
