//
//  LocationDelegate.swift
//  ios-wetterapp
//
//  Created by admin on 11.01.24.
//

import Foundation
import CoreLocation

class LocationDelegate: NSObject, CLLocationManagerDelegate {
    
    private var locationManager = CLLocationManager()
    
    private(set) var last: CLLocationCoordinate2D? 
    
    private var _last: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        NSLog("New location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("Location update failed with error: \(error.localizedDescription)")
    }
    
}
