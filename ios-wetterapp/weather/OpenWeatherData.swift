import Foundation

struct ListMain: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let sea_level: Double
    let grnd_level: Double
    let humidity: Int
    let temp_kf: Double
}

struct ListWeather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct ListClouds: Codable {
    let all: Int
}

struct ListWind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct ListRain: Codable {
    let threeHour: Double?
    
    private enum CodingKeys: String, CodingKey {
        case threeHour = "3h"
    }
}

struct ListSnow: Codable {
    let threeHour: Double?
    
    private enum CodingKeys: String, CodingKey {
        case threeHour = "3h"
    }
}

struct ListSys: Codable {
    let pod: String
}

struct Forecast: Codable {
    let dt: Int
    let main: ListMain
    let weather: [ListWeather]
    let clouds: ListClouds
    let wind: ListWind
    let visibility: Int
    let pop: Double
    let rain: ListRain?
    let snow: ListSnow?
    let sys: ListSys
    let dt_txt: String
}

struct CityCoord: Codable {
    let lat: Double
    let lon: Double
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: CityCoord
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

struct ApiResponse: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [Forecast]
    let city: City
}
