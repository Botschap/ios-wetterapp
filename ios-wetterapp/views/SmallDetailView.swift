//
//  SmallDetailView.swift
//  ios-wetterapp
//
//  Created by admin on 18.02.24.
//

import Foundation
import UIKit

class SmallDetailView: UIView, WeatherDataHandler {
    
    var index: Int = -1
    var weatherIcon: UIImageView = UIImageView(image: UIImage(systemName: "sun.max.fill"))
    let timeLabel: UILabel = UILabel()
    let temperatureLabel: UILabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        timeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        addSubview(weatherIcon)
        addSubview(timeLabel)
        addSubview(temperatureLabel)
        disableAutoresizingMaskConstraints()
        computeLayout()
    }
    
    func computeLayout() {
        let views: [String:Any] = [
            "weather": weatherIcon,
            "time": timeLabel,
            "temp": temperatureLabel
        ]
        let metrics: [String:Int] = [
            "s": 10,
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[time]-s-[weather(>=20)]-s-[temp]-|", metrics: metrics, views: views))
        
    }
    
    
    func handleNewWeatherData(_ weather: ApiResponse) {
        if index > -1 {
            let currentWeather = weather.list[index]
            //to ensure that there only is one icon
            weatherIcon.removeFromSuperview()
            if currentWeather.rain != nil {
                weatherIcon = UIImageView(image: UIImage(systemName: "cloud.rain.fill"))
            } else if currentWeather.snow != nil {
                weatherIcon = UIImageView(image: UIImage(systemName: "cloud.snow.fill"))
            } else if currentWeather.wind.speed > 7 {
                weatherIcon = UIImageView(image: UIImage(systemName: "wind"))
            }else if currentWeather.clouds.all >= 40 {
                weatherIcon = UIImageView(image: UIImage(systemName: "cloud.fill"))
            }else {
                weatherIcon = UIImageView(image: UIImage(systemName: "sun.max.fill"))
            }
            temperatureLabel.text = "\(Int(currentWeather.main.temp.rounded()))°"
            if index == 0 {
                timeLabel.text = "Jetzt"
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                if let date = dateFormatter.date(from: currentWeather.dt_txt) {
                    let calendar = Calendar.current
                    let hour = calendar.component(.hour, from: date)
                    timeLabel.text = "\(hour) Uhr"
                }
                timeLabel.text = "NaN"
            }
        } else {
            //todo errorhandling
            NSLog("invalid index for weatherdetail")
        }
        for subview in subviews {
            if let handler = subview as? WeatherDataHandler {
                handler.handleNewWeatherData(weather)
            }
        }
        setNeedsDisplay()
    }
}
