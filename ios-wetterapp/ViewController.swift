//
//  ViewController.swift
//  ios-wetterapp
//
//  Created by admin on 04.01.24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    private var locationManager: LocationManager = LocationManager.getInstance()
    private var weather: OpenWeather = try! OpenWeather.getInstance()
    private let weatherModel: WeatherModel = WeatherModel()
    
    private let headerView: HeaderView = HeaderView()
    private let tempView: TemperaturView = TemperaturView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.red
        view.addSubview(headerView)
        view.addSubview(tempView)
        
        view?.disableAutoresizingMaskConstraints()
        computeLayout()
        NSLog("setup complete")
        
        waitForNewLocation()
        
    }
    
    func waitForNewLocation() {
        DispatchQueue.main.async {
            self.locationManager.waitForLocationChange{newLocation in
                self.weather.fetchWeatherData(newLocation, { newData in
                    self.weatherModel.data = newData
                    NSLog("new weatherdata!")
                })
            }
        }
    }
    
    func computeLayout(){
        let views: [String : Any] = [
            "header": headerView,
            "temp": tempView
        ]
        
        let metrics: [String : Int] = [
            "s": 50
        ]
        
        let constraintsAsStrings: [String] = [
            "H:|-s-[header]-s-|",
            "H:|-s-[temp]-s-|",
            "V:|-s-[header]-s-[temp]-(>=s)-|"
        ]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: metrics, views: views))
    }
    
    
    
    
}

