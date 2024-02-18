//
//  WeatherView.swift
//  ios-wetterapp
//
//  Created by admin on 17.02.24.
//

import Foundation
import UIKit

class WeatherView: UIView, WeatherDataHandler {
    
    private let headerView: HeaderView = HeaderView()
    private let tempView: TemperaturView = TemperaturView()
    private let dailyView: DailyView = DailyView()
    private let forecastView: ForecastView = ForecastView()
    
    override func layoutSubviews() {

        addSubview(headerView)
        addSubview(tempView)
        addSubview(dailyView)
        addSubview(forecastView)
        
        disableAutoresizingMaskConstraints()
        computeLayout()
    }
    
    func computeLayout(){
        let views: [String : Any] = [
            "header": headerView,
            "temp": tempView,
            "daily": dailyView,
            "forecast": forecastView
        ]
        
        let metrics: [String : Int] = [
            "s": 20,
            "m": 30
        ]
        
        let constraintsAsStrings: [String] = [
            "H:|-s-[header]-s-|",
            "H:|-s-[temp]-s-|",
            "H:[daily(>=temp)]",
            "H:|-s-[forecast]-s-|",
            "V:|-m-[header]-s-[temp]-s-[daily]-s-[forecast]-(>=m)-|"
        ]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: metrics, views: views))
        dailyView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func handleNewWeatherData(_ weather: ApiResponse){
        for subview in subviews {
            if let handler = subview as? WeatherDataHandler {
                handler.handleNewWeatherData(weather)
            }
        }
        setNeedsDisplay()
    }
    
}
