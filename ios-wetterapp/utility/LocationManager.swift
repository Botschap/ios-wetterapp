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
            locationCompletionHandler?(last)
        }
    }
    
    private static var SINGLETON: LocationManager?
    
    private var locationCompletionHandler: ((CLLocation?) -> Void)?
    
    private var errorCompletionHandler: (() -> Void)?
    
    private override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 1000
        locationManager.allowsBackgroundLocationUpdates = true
    }
    
    func waitForLocationChange (_ completion: @escaping (CLLocation?) -> Void){
        locationCompletionHandler = completion
    }
    
    func waitForErrorOccured(_ completion: @escaping () -> Void) {
        errorCompletionHandler = completion
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
        errorCompletionHandler?()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            startUpdatingLocation()
            NSLog("Location authorization status changed to authorized but not all features will be working correctly")
        case .authorizedAlways:
            // Location services authorized, you can start location updates here if needed.
            startUpdatingLocation()
            NSLog("Location authorization status changed to authorized")
        case .denied, .restricted:
            // Location services denied or restricted, handle accordingly.
            NSLog("Location authorization status changed to denied or restricted")
            errorCompletionHandler?()
        case .notDetermined:
            // Authorization status not determined yet.
            NSLog("Location authorization status not determined")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            NSLog("Error during authorization check")
            errorCompletionHandler?()
            break
        }
    }
    
    func startUpdatingLocation(){
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.startUpdatingLocation()
        }
        
    }
    
}

enum LocationAuthorizationError: Error {
    case runtimeException(String)
}
