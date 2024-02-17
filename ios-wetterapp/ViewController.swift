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
    
    let weatherView: WeatherView = WeatherView()
    let loadingView: LoadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        waitForNewLocation()
        
        view.addSubview(loadingView)
        setupConstraints(for: loadingView)
        
        NSLog("setup complete")
        
    }
    
    func waitForNewLocation() {
        DispatchQueue.global().async {
            self.locationManager.waitForLocationChange{newLocation in
                self.weather.fetchWeatherData(newLocation, { newData in
                    self.weatherModel.data = newData
                    NSLog("new weatherdata!")
                    DispatchQueue.main.async {
                        self.refresh()
                    }
                })
            }
        }
    }
    
    
    
    func refresh() {
        if let data = weatherModel.data {
            if loadingView.superview != nil {
                loadingView.removeFromSuperview()
                view.addSubview(weatherView)
                setupConstraints(for: weatherView)
                view.layoutIfNeeded()
            }
            
            weatherView.handleNewWeatherData(data)
        }
        
    }
    
    func setupConstraints(for view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            view.topAnchor.constraint(equalTo: self.view.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
}

