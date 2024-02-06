//
//  WeatherData.swift
//  ios-wetterapp
//
//  Created by admin on 11.01.24.
//

import Foundation

import Foundation

struct WeatherData: Decodable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let offset: Double
    let currently: CurrentWeather
    let hourly: HourlyWeather
    let daily: DailyWeather
}

struct CurrentWeather: Decodable {
    let time: TimeInterval
    let summary: String
    let icon: String
    let precipIntensity: Double
    let precipType: String
    let temperature: Double
    let apparentTemperature: Double
    let dewPoint: Double
    let pressure: Double
    let windSpeed: Double
    let windBearing: Int
    let cloudCover: Double
}

struct HourlyWeather: Decodable {
    let data: [HourlyData]
}

struct HourlyData: Decodable {
    let time: TimeInterval
    let icon: String
    let summary: String
    let precipAccumulation: Double
    let precipType: String
    let temperature: Double
    let apparentTemperature: Double
    let dewPoint: Double
    let pressure: Double
    let windSpeed: Double
    let windBearing: Int
    let cloudCover: Double
}

struct DailyWeather: Decodable {
    let data: [DailyData]
}

struct DailyData: Decodable {
    let time: TimeInterval
    let icon: String
    let summary: String
    let sunriseTime: TimeInterval
    let sunsetTime: TimeInterval
    let moonPhase: Double
    let precipAccumulation: Double
    let precipType: String
    let temperatureHigh: Double
    let temperatureHighTime: TimeInterval
    let temperatureLow: Double
    let temperatureLowTime: TimeInterval
    let apparentTemperatureHigh: Double
    let apparentTemperatureHighTime: TimeInterval
    let apparentTemperatureLow: Double
    let apparentTemperatureLowTime: TimeInterval
    let dewPoint: Double
    let pressure: Double
    let windSpeed: Double
    let windBearing: Int
    let cloudCover: Double
    let temperatureMin: Double
    let temperatureMinTime: TimeInterval
    let temperatureMax: Double
    let temperatureMaxTime: TimeInterval
    let apparentTemperatureMin: Double
    let apparentTemperatureMinTime: TimeInterval
    let apparentTemperatureMax: Double
    let apparentTemperatureMaxTime: TimeInterval
}

