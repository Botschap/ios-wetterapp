//
//  WeatherData.swift
//  ios-wetterapp
//
//  Created by admin on 11.01.24.
//

import Foundation

struct WeatherData: Codable {
    let time: Int
    let summary: String
    let icon: String
    let nearestStormDistance: Int
    let nearestStormBearing: Int
    let precipIntensity: Int
    let precipProbability: Int
    let precipIntensityError: Int
    let precipType: String
    let temperature: Double
    let apparentTemperature: Double
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windBearing: Double
    let cloudCover: Int
    let uvIndex: Double
    let visibility: Int
    let ozone: Double
}
