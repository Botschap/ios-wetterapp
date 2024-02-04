//
//  LocationDelegate.swift
//  ios-wetterapp
//
//  Created by admin on 11.01.24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private var locationManager = CLLocationManager()
    
    var delegate: CLLocationManagerDelegate?
    
    private (set) var last: CLLocation? {
        didSet {
            completionHandler?(last)
        }
    }
    
    private var completionHandler: ((CLLocation?) -> Void)?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
    }
    
    func waitForLocationChange (_ completion: @escaping (CLLocation?) -> Void){
        self.completionHandler = completion
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        NSLog("New location: \(lastLocation.coordinate.latitude), \(lastLocation.coordinate.longitude)")
        last = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("Location update failed with error: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            // Location services authorized, you can start location updates here if needed.
            locationManager.startUpdatingLocation()
            NSLog("Location authorization status changed to authorized")
        case .denied, .restricted:
            // Location services denied or restricted, handle accordingly.
            NSLog("Location authorization status changed to denied or restricted")
        case .notDetermined:
            // Authorization status not determined yet.
            NSLog("Location authorization status not determined")
        @unknown default:
            NSLog("Error during authorization check")
            break
        }
    }
    
}

