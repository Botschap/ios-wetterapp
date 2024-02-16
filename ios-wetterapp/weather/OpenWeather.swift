//
//  OpenWeather.swift
//  ios-wetterapp
//
//  Created by admin on 16.02.24.
//

import Foundation
import CoreLocation

enum EnvVariableMissingError: Error {
    case runtimeException(String)
}

class OpenWeather{
    
    private static var SINGLETON: OpenWeather?
    
    let API_BASE_PATH: String
    
    private var jsonDecoder = JSONDecoder()
    
    private let numberFormatter: NumberFormatter
    
    private (set) var fetchedData: ApiResponse? {
        didSet {
            completionHandler?(self.fetchedData)
        }
    }
    
    private var completionHandler: ((ApiResponse?) -> Void)?
    
    
    
    private init() throws {
        guard let apiKey = ProcessInfo.processInfo.environment["openweather_api_key"] else {
            throw EnvVariableMissingError.runtimeException( "API-Key kann nicht gefunden werden")
        }
        self.API_BASE_PATH = "https://api.openweathermap.org/data/2.5/forecast?units=metric&appid=\(apiKey)"
        self.numberFormatter = NumberFormatter()
        self.numberFormatter.minimumFractionDigits = 2
        self.numberFormatter.maximumFractionDigits = 2
    }
    
    static func getInstance() throws -> OpenWeather {
        if OpenWeather.SINGLETON == nil {
            do {
                OpenWeather.SINGLETON = try OpenWeather()
            } catch EnvVariableMissingError.runtimeException(let message) {
                NSLog("PirateWeather Instanz konnte nicht erzeugt werden: %s", message)
                throw EnvVariableMissingError.runtimeException(message)
            }
        }
        return OpenWeather.SINGLETON!
    }
    
    fileprivate func createURL(_ location: CLLocation?) -> URL? {
        if let currentLocation = location?.coordinate {
            let latitude = currentLocation.latitude
            let longitude = currentLocation.longitude
            return URL(string: "\(API_BASE_PATH)&lat=\(latitude)&lon=\(longitude)")
        }
        return nil
    }
    
    func fetchWeatherData (_ location: CLLocation?, _ completion: @escaping (ApiResponse?) -> Void) -> Void {
        self.completionHandler = completion
        
        if let url = createURL(location) {
            APIClient.fetchData(from: url) { result in
                switch result {
                case .success(let data):
                    let weather: ApiResponse = try! self.jsonDecoder.decode(ApiResponse.self, from: data)
                    completion(weather)
                case .failure(let error):
                    NSLog("Error during fetch: %s", error.localizedDescription)
                }
            }
        }
    }
}
