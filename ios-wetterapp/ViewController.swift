//
//  ViewController.swift
//  ios-wetterapp
//
//  Created by admin on 04.01.24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, LocationManagerDelegate {
    
    private var locationManager: LocationManager!
    
    
    
    func didUpdateLocation(_ location: CLLocation) {
            // Update the label with the current location
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            NSLog("Latitude: \(latitude), Longitude: \(longitude)")
        }

        func didFailWithError(_ error: Error) {
            // Handle location error
            NSLog("Error getting location: \(error.localizedDescription)")
        }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let weather = try! PirateWeather.getInstance()
        locationManager = LocationManager()
        locationManager.delegate = self
        while(true) {
            weather.fetchWeatherData()
            Thread.sleep(forTimeInterval: 5.0)
        }
    }


}

