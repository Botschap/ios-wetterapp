//
//  DailyView.swift
//  ios-wetterapp
//
//  Created by admin on 18.02.24.
//

import Foundation
import UIKit

class DailyView: UIView, WeatherDataHandler {
    
    var smallDetailViews: [SmallDetailView] = [SmallDetailView(), SmallDetailView(), SmallDetailView(), SmallDetailView(), SmallDetailView()]
    
    let forecastLabel: UILabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for view in smallDetailViews {
            addSubview(view)
        }
        smallDetailViews[0].isCurrent = true
        addSubview(forecastLabel)
        
        disableAutoresizingMaskConstraints()
        computeLayout()
    }
    
    func computeLayout(){
        let views: [String:Any] = [
            "one": smallDetailViews[1],
            "two": smallDetailViews[2],
            "three": smallDetailViews[3],
            "four": smallDetailViews[4],
            "zero": smallDetailViews[0],
            "forecast": forecastLabel
        ]
        let constraintsAsStrings: [String] = [
            "H:[forecast]",
            "H:|-[zero(==one)]-[one(==zero)]-[two(==one)]-[three(==one)]-[four(==one)]-|",
            "V:|-[forecast]-[zero]-|",
            "V:|-[forecast]-[one]-|",
            "V:|-[forecast]-[two]-|",
            "V:|-[forecast]-[three]-|",
            "V:|-[forecast]-[four]-|",
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: nil, views: views))
        forecastLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    
    func handleNewWeatherData(_ weather: ApiResponse) {
        forecastLabel.text = weather.list[0].weather[0].description
        var counter: Int = 0
        for subview in subviews {
            if let handler = subview as? WeatherDataDetailHandler {
                handler.handleNewWeatherData(weather.list[counter])
                counter += 1
            }
        }
    }
    
}
