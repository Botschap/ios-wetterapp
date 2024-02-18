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
        
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        temperatureLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textAlignment = NSTextAlignment.center
        temperatureLabel.textAlignment = NSTextAlignment.center
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
        let constraintsAsStrings: [String] = [
            "V:|-[time]-s-[weather(==40)]-s-[temp]-|",
            "H:|-[time]-|",
            "H:|-[weather(==40)]-|",
            "H:|-[temp]-|",
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: metrics, views: views))
        
    }
    
    
    func handleNewWeatherData(_ weather: ApiResponse) {
        if index > -1 {
            let currentWeather = weather.list[index]
            //to ensure that there only is one icon
            weatherIcon.removeFromSuperview()
            if currentWeather.rain != nil {
                weatherIcon = UIImageView(image: UIImage(systemName: "cloud.rain.fill"))
                weatherIcon.tintColor = UIColor.systemBlue
            } else if currentWeather.snow != nil {
                weatherIcon = UIImageView(image: UIImage(systemName: "cloud.snow.fill"))
                weatherIcon.tintColor = UIColor.systemGray
            } else if currentWeather.wind.speed > 7 {
                weatherIcon = UIImageView(image: UIImage(systemName: "wind"))
                weatherIcon.tintColor = UIColor.systemGray
            }else if currentWeather.clouds.all >= 40 {
                weatherIcon = UIImageView(image: UIImage(systemName: "cloud.fill"))
                weatherIcon.tintColor = UIColor.systemGray
            }else {
                weatherIcon = UIImageView(image: UIImage(systemName: "sun.max.fill"))
                weatherIcon.tintColor = UIColor.systemYellow
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
                }else {
                    timeLabel.text = "NaN"
                }
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
        //setNeedsDisplay()
    }
}
