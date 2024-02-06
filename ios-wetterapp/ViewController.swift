//
//  ViewController.swift
//  ios-wetterapp
//
//  Created by admin on 04.01.24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    private var locationManager: LocationManager = LocationManager()
    private var weather: PirateWeather = try! PirateWeather.getInstance()
    private let weatherModel: WeatherModel = WeatherModel()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NSLog("setup complete")
        waitForNewLocation()
    }
    
    func waitForNewLocation() {
        DispatchQueue.main.async {
            self.locationManager.waitForLocationChange{newLocation in
                self.weather.fetchWeatherData(newLocation, { newData in
                    self.weatherModel.data = newData
                    NSLog("Neues Wettermodel: \(String(describing: self.weatherModel.data))")
                })
            }
        }
    }
    
    
}

