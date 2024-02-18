//
//  ForecastView.swift
//  ios-wetterapp
//
//  Created by admin on 18.02.24.
//

import Foundation
import UIKit

class ForecastView: UIView, WeatherDataHandler {
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        disableAutoresizingMaskConstraints()
        computeLayout()
    }
    
    func computeLayout(){
        
    }
    
    func handleNewWeatherData(_ weather: ApiResponse) {
        for subview in subviews {
            if let handler = subview as? WeatherDataHandler {
                handler.handleNewWeatherData(weather)
            }
        }
    }
    
}
