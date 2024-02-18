//
//  DemoView.swift
//  ios-wetterapp
//
//  Created by admin on 17.02.24.
//

import Foundation
import UIKit

class HeaderView : UIView, WeatherDataHandler {
    
    let cityName: UILabel = UILabel()
    //to ensure that the icon is always present for the constraints
    var weatherIcon: UIImageView = UIImageView(image: UIImage(systemName: "sun.max.fill"))
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cityName.font = UIFont.boldSystemFont(ofSize: 25)
        addSubview(cityName)
        addSubview(weatherIcon)
        //needs to be set to disable autoresizing for standard componentes
        disableAutoresizingMaskConstraints()
        computeLayout()
        
    }
    
    func computeLayout() {
        let views: [String:Any] = [
            "city": cityName,
            "icon": weatherIcon
        ]
        let metrics: [String:Int] = [
            "s": 20,
        ]
        let constraintsAsStrings: [String] = [
            "H:|-[city]-(>=s)-[icon(==60)]-|",
            "V:|-[icon(==60)]-|",
            "V:|-[city(==icon)]-|"
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: metrics, views: views))
        
    }
    
    func handleNewWeatherData(_ weather: ApiResponse) {
        cityName.text = weather.city.name
        let currentWeather = weather.list[0]
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
        func handleNewWeatherData(_ weather: ApiResponse){
            for subview in subviews {
                if let handler = subview as? WeatherDataHandler {
                    handler.handleNewWeatherData(weather)
                }
            }
        }
    }
    
}
