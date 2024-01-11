//
//  PirateWeather.swift
//  ios-wetterapp
//
//  Created by admin on 11.01.24.
//

import Foundation

class PirateWeather{
    
    public static let singleton: PirateWeather = PirateWeather()
    
    static let locationDelegate: LocationDelegate = LocationDelegate()
    
    let API_BASE_PATH: String?
    
    private init(){
        if let apiKey = ProcessInfo.processInfo.environment["pirate_weather_api_key"]{
            API_BASE_PATH = "https://api.pirateweather.net/forecast/" + apiKey
        } else {
            API_BASE_PATH = nil
        }
    }
    
    func fetchWeatherData () {
        NSLog("\(String(describing: PirateWeather.locationDelegate.last))")
    }
}
