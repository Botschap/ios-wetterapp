//
//  PirateWeather.swift
//  ios-wetterapp
//
//  Created by admin on 11.01.24.
//

import Foundation

enum EnvVariableMissingError: Error {
    case runtimeException(String)
}

class PirateWeather{
    
    private static var SINGLETON: PirateWeather?
    
    static let LOCATION_DELEGATE: LocationManager = LocationManager()
    
    let API_BASE_PATH: String
    
    private var jsonDecoder = JSONDecoder()
    
    private init() throws {
        if let apiKey = ProcessInfo.processInfo.environment["pirate_weather_api_key"]{
            API_BASE_PATH = "https://api.pirateweather.net/forecast/" + apiKey
        } else {
            throw EnvVariableMissingError.runtimeException( "API-Key kann nicht gefunden werden")
        }
    }
    
    static func getInstance() throws -> PirateWeather {
        if PirateWeather.SINGLETON == nil {
            do {
                PirateWeather.SINGLETON = try PirateWeather()
            } catch EnvVariableMissingError.runtimeException(let message) {
                NSLog("PirateWeather Instanz konnte nicht erzeugt werden: %s", message)
                throw EnvVariableMissingError.runtimeException(message)
            }
        }
        return PirateWeather.SINGLETON!
    }
    
    func fetchWeatherData () -> WeatherData? {
        /*if let currentLocation = PirateWeather.LOCATION_DELEGATE.last {
            let latitude = currentLocation.latitude.formatted()
            let longitude = currentLocation.longitude.formatted()
            if let url = URL(string: API_BASE_PATH + latitude + "/" + longitude) {
                var weatherData: WeatherData?
                APIClient.fetchData(from: url) { result in
                    switch result {
                    case .success(let data):
                        let weather: WeatherData = try! self.jsonDecoder.decode(WeatherData.self, from: data)
                        NSLog("%d", weather.apparentTemperature)
                        weatherData = weather
                    case .failure(let error):
                        NSLog("Error during fetch: %s", error.localizedDescription)
                        weatherData = nil
                    }
                }
                return weatherData
            }
        }*/
        return nil
    }
}
