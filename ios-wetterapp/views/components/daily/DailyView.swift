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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for view in smallDetailViews {
            addSubview(view)
        }
        smallDetailViews[0].isCurrent = true
        
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
        ]
        let constraintsAsStrings: [String] = [
            "H:|-[zero(==one)]-[one(==zero)]-[two(==one)]-[three(==one)]-[four(==one)]-|",
            "V:|-[zero]-|",
            "V:|-[one]-|",
            "V:|-[two]-|",
            "V:|-[three]-|",
            "V:|-[four]-|",
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: nil, views: views))
    }
    
    
    func handleNewWeatherData(_ weather: ApiResponse) {
        var counter: Int = 0
        for subview in subviews {
            if let handler = subview as? WeatherDataDetailHandler {
                handler.handleNewWeatherData(weather.list[counter])
                counter += 1
            }
        }
    }
    
}
