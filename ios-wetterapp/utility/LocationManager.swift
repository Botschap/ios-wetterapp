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
    
    private static var SINGLETON: LocationManager?
    
    private var completionHandler: ((CLLocation?) -> Void)?
    
    private override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 1000
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.requestAlwaysAuthorization()
    }
    
    func waitForLocationChange (_ completion: @escaping (CLLocation?) -> Void){
        self.completionHandler = completion
    }
    
    static func getInstance() -> LocationManager {
        if LocationManager.SINGLETON == nil {
            LocationManager.SINGLETON = LocationManager()
        }
        return LocationManager.SINGLETON!
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
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            NSLog("Location authorization status changed to authorized but not all features will be working correctly")
        case .authorizedAlways:
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

