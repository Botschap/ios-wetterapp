import Foundation

struct WeatherResponse: Decodable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let offset: Int
    let elevation: Int
    let currently: CurrentWeather
    let minutely: MinutelyWeather
    let hourly: HourlyWeather
    let daily: DailyWeather
    let alerts: [Alert]?
    let flags: WeatherFlags
}

struct CurrentWeather: Decodable {
    let time: Int
    let summary: String
    let icon: String
    let nearestStormDistance: Int?
    let nearestStormBearing: Int?
    let precipIntensity: Double?
    let precipProbability: Double?
    let precipIntensityError: Double?
    let precipType: String?
    let temperature: Double?
    let apparentTemperature: Double?
    let dewPoint: Double?
    let humidity: Double?
    let pressure: Double?
    let windSpeed: Double?
    let windGust: Double?
    let windBearing: Double?
    let cloudCover: Double?
    let uvIndex: Double?
    let visibility: Double?
    let ozone: Double?
}

struct MinutelyWeather: Decodable {
    let summary: String
    let icon: String
    let data: [MinutelyData]
}

struct MinutelyData: Decodable {
    let time: Int
    let precipIntensity: Double
    let precipProbability: Double
    let precipIntensityError: Double
    let precipType: String?
    // Add other properties as needed
}

struct HourlyWeather: Decodable {
    let summary: String
    let icon: String
    let data: [HourlyData]
}

struct HourlyData: Decodable {
    let time: Int
    let icon: String
    let summary: String
    let precipIntensity: Double
    let precipProbability: Double
    let precipIntensityError: Double
    let precipAccumulation: Double
    let precipType: String?
    let temperature: Double
    let apparentTemperature: Double
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windBearing: Double
    let cloudCover: Double
    let uvIndex: Double
    let visibility: Double
    let ozone: Double
    // Add other properties as needed
}

struct DailyWeather: Decodable {
    let summary: String
    let icon: String
    let data: [DailyData]
}

struct DailyData: Decodable {
    let time: Int
    let icon: String
    let summary: String
    let sunriseTime: Int
    let sunsetTime: Int
    let moonPhase: Double
    let precipIntensity: Double
    let precipIntensityMax: Double
    let precipIntensityMaxTime: Int
    let precipProbability: Double
    let precipAccumulation: Double
    let precipType: String?
    let temperatureHigh: Double
    let temperatureHighTime: Int
    let temperatureLow: Double
    let temperatureLowTime: Int
    let apparentTemperatureHigh: Double
    let apparentTemperatureHighTime: Int
    let apparentTemperatureLow: Double
    let apparentTemperatureLowTime: Int
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windGustTime: Int
    let windBearing: Double
    let cloudCover: Double
    let uvIndex: Double
    let uvIndexTime: Int
    let visibility: Double
    let temperatureMin: Double
    let temperatureMinTime: Int
    let temperatureMax: Double
    let temperatureMaxTime: Int
    let apparentTemperatureMin: Double
    let apparentTemperatureMinTime: Int
    let apparentTemperatureMax: Double
    let apparentTemperatureMaxTime: Int
    // Add other properties as needed
}

struct Alert: Decodable {
    let title: String
    let regions: [String]
    let severity: String
    let time: Int
    let expires: Int
    let description: String
    let uri: String
}

struct WeatherFlags: Decodable {
    let sources: [String]
    let sourceTimes: [String: String]
    //muss leider so, weil in dem JSON nearest-station steht --> kann nicht automatisch transformiert werden
    let nearestStation: Int?
    let units: String
    let version: String
}
