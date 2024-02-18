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
    
    override func layoutSubviews() {

        addSubview(headerView)
        addSubview(tempView)
        
        disableAutoresizingMaskConstraints()
        computeLayout()
    }
    
    func computeLayout(){
        let views: [String : Any] = [
            "header": headerView,
            "temp": tempView
        ]
        
        let metrics: [String : Int] = [
            "s": 20,
            "m": 30
        ]
        
        let constraintsAsStrings: [String] = [
            "H:|-s-[header]-s-|",
            "H:|-s-[temp]-s-|",
            "V:|-30-[header]-s-[temp]-(>=30)-|"
        ]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: metrics, views: views))
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
