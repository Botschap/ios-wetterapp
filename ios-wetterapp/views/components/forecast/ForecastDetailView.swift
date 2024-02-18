//
//  ForecastDetailView.swift
//  ios-wetterapp
//
//  Created by admin on 18.02.24.
//

import Foundation
import UIKit

class ForecastDetailView: UIView, WeatherDataForecastHandler {
    
    var dayOfWeekLabel: UILabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dayOfWeekLabel.font = UIFont.systemFont(ofSize: 16)
        addSubview(dayOfWeekLabel)
        
        disableAutoresizingMaskConstraints()
        computeLayout()
    }
    
    func computeLayout(){
        let views: [String:Any] = [
            "day": dayOfWeekLabel,
        ]
        let metrics: [String:Int] = [
            "s": 10,
        ]
        let constraintsAsStrings: [String] = [
            "H:|-[day]-|",
            "V:|-[day]-|",
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: metrics, views: views))
    }
    
    func handleNewWeatherData(_ weather: [Forecast]) {
        //todo
        dayOfWeekLabel.text = "Tag"
    }
}
