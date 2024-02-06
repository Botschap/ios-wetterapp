//
//  PirateWeather.swift
//  ios-wetterapp
//
//  Created by admin on 11.01.24.
//

import Foundation
import CoreLocation

enum EnvVariableMissingError: Error {
    case runtimeException(String)
}

class PirateWeather{
    
    private static var SINGLETON: PirateWeather?
    
    let API_BASE_PATH: String
    
    private var jsonDecoder = JSONDecoder()
    
    private let numberFormatter: NumberFormatter
    
    private (set) var fetchedData: WeatherResponse? {
        didSet {
            completionHandler?(self.fetchedData)
        }
    }
    
    private var completionHandler: ((WeatherResponse?) -> Void)?
    
    
    
    private init() throws {
        if let apiKey = ProcessInfo.processInfo.environment["pirate_weather_api_key"]{
            self.API_BASE_PATH = "https://api.pirateweather.net/forecast/" + apiKey
        } else {
            throw EnvVariableMissingError.runtimeException( "API-Key kann nicht gefunden werden")
        }
        self.numberFormatter = NumberFormatter()
        self.numberFormatter.minimumFractionDigits = 2
        self.numberFormatter.maximumFractionDigits = 2
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
    
    fileprivate func createURL(_ location: CLLocation?) -> URL? {
        if let currentLocation = location?.coordinate {
            let latitude = currentLocation.latitude
            let longitude = currentLocation.longitude
            return URL(string: "\(API_BASE_PATH)/\(latitude),\(longitude)?units=ca")
        }
        return nil
    }
    
    func fetchWeatherData (_ location: CLLocation?, _ completion: @escaping (WeatherResponse?) -> Void) -> Void {
        self.completionHandler = completion
        
        if let url = createURL(location) {
            APIClient.fetchData(from: url) { result in
                switch result {
                case .success(let data):
                    let weather: WeatherResponse = try! self.jsonDecoder.decode(WeatherResponse.self, from: data)
                    completion(weather)
                case .failure(let error):
                    NSLog("Error during fetch: %s", error.localizedDescription)
                }
            }
        }
    }
}
