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
    
    private var headerView: HeaderView = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        headerView.backgroundColor = UIColor.red
        view.addSubview(headerView)
        
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
            "header": headerView
        ]
        
        let metrics: [String : Int] = [
            "s": 50
        ]
        
        let constraintsAsStrings: [String] = [
            "H:|-s-[header]-s-|",
            "V:|-s-[header]-s-|"
        ]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: metrics, views: views))
    }
    
    
    
    
}

