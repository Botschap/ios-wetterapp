//
//  ForecastDetailView.swift
//  ios-wetterapp
//
//  Created by admin on 18.02.24.
//

import Foundation
import UIKit

class ForecastDetailView: UIView, WeatherDataForecastHandler {
    
    let dayOfWeekLabel: UILabel = UILabel()
    let tempMinLabel: UILabel = UILabel()
    let tempMaxLabel: UILabel = UILabel()
    let descLabel: UILabel = UILabel()
    var weatherIcon: UIImageView = UIImageView(image: UIImage(systemName: "sun.max.fill"))
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dayOfWeekLabel.font = UIFont.systemFont(ofSize: 14)
        tempMaxLabel.font = UIFont.systemFont(ofSize: 14)
        tempMinLabel.font = UIFont.systemFont(ofSize: 14)
        descLabel.font = UIFont.systemFont(ofSize: 8)
        addSubview(dayOfWeekLabel)
        addSubview(tempMaxLabel)
        addSubview(tempMinLabel)
        addSubview(weatherIcon)
        addSubview(descLabel)
        
        disableAutoresizingMaskConstraints()
        computeLayout()
    }
    
    func computeLayout(){
        let views: [String:Any] = [
            "day": dayOfWeekLabel,
            "min": tempMinLabel,
            "max": tempMaxLabel,
            "icon": weatherIcon,
            "desc": descLabel
        ]
        let metrics: [String:Int] = [
            "s": 30,
        ]
        let constraintsAsStrings: [String] = [
            "H:|-[day(30)]-[icon(>=40)]-s-[desc(==60)]-s-[min(==40)]-s-[max(==40)]-|",
            "V:|-[day(<=icon)]-|",
            "V:|-[icon(>=40)]-|",
            "V:|-[min(<=icon)]-|",
            "V:|-[max(<=icon)]-|",
            "V:|-[desc(<=icon)]-|",
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: metrics, views: views))
    }
    
    func handleNewWeatherData(_ weather: [Forecast]) {
        //todo
        weatherIcon.removeFromSuperview()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let aktDate: Date = dateFormatter.date(from: weather[0].dt_txt){
            let weekday = Calendar.current.component(.weekday, from: aktDate)
            
            dayOfWeekLabel.text = Weekday(rawValue: weekday)?.description
        } else {
            dayOfWeekLabel.text = "Tag"
        }
        var minTemp: Int = 100
        var maxTemp: Int = -30
        var rain: Bool = false
        var snow: Bool = false
        var wind: Bool = false
        var cloud: Bool = false
        
        for forecast in weather {
            if Int(forecast.main.temp_min.rounded()) < minTemp {
                minTemp = Int(forecast.main.temp_min.rounded())
            }
            if Int(forecast.main.temp_max.rounded()) > maxTemp {
                maxTemp = Int(forecast.main.temp_max.rounded())
            }
            if !rain {
                rain = forecast.rain != nil
            }
            if !snow {
                snow = forecast.snow != nil
            }
            if !wind {
                wind = forecast.wind.speed > 15
            }
            if !cloud {
                cloud = forecast.clouds.all > 40
            }
        }
        
        tempMaxLabel.text = "T: \(maxTemp)°"
        tempMinLabel.text = "H: \(minTemp)°"
        
        if rain {
            weatherIcon = UIImageView(image: UIImage(systemName: "cloud.rain.fill"))
            weatherIcon.tintColor = UIColor.systemBlue
            for forecast in weather {
                if forecast.weather[0].description.contains("Regen"){
                    descLabel.text = forecast.weather[0].description
                }
            }
        } else if snow {
            weatherIcon = UIImageView(image: UIImage(systemName: "cloud.snow.fill"))
            weatherIcon.tintColor = UIColor.systemGray
            for forecast in weather {
                if forecast.weather[0].description.contains("Schnee"){
                    descLabel.text = forecast.weather[0].description
                }
            }
        } else if wind {
            weatherIcon = UIImageView(image: UIImage(systemName: "wind"))
            weatherIcon.tintColor = UIColor.systemGray
            for forecast in weather {
                if forecast.weather[0].description.contains("Wind"){
                    descLabel.text = forecast.weather[0].description
                }
            }
        } else if cloud {
            weatherIcon = UIImageView(image: UIImage(systemName: "cloud.fill"))
            weatherIcon.tintColor = UIColor.systemGray
            descLabel.text = weather[0].weather[0].description
        } else {
            weatherIcon = UIImageView(image: UIImage(systemName: "sun.max.fill"))
            weatherIcon.tintColor = UIColor.systemYellow
            descLabel.text = weather[0].weather[0].description
        }
            
        
    }
}

enum Weekday: Int {
    
    case montag = 1
    case dienstag
    case mittwoch
    case donnerstag
    case freitag
    case samstag
    case sonntag

    var description: String {
        switch self {
        case .sonntag: return "So"
        case .montag: return "Mo"
        case .dienstag: return "Di"
        case .mittwoch: return "Mi"
        case .donnerstag: return "Do"
        case .freitag: return "Fr"
        case .samstag: return "Sa"
        }
    }
}
