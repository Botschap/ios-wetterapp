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
    
    private var demoView: DemoView = DemoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        demoView.backgroundColor = UIColor.red
        view.addSubview(demoView)
        
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
            "demo": demoView
        ]
        
        let metrics: [String : Int] = [
            "s": 50
        ]
        
        let constraintsAsStrings: [String] = [
            "H:|-s-[demo]-s-|",
            "V:|-s-[demo]-s-|"
        ]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: metrics, views: views))
    }
    
    
    
    
}

