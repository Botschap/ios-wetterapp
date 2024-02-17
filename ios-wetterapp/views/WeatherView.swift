//
//  WeatherView.swift
//  ios-wetterapp
//
//  Created by admin on 17.02.24.
//

import Foundation
import UIKit

class WeatherView: UIView {
    
    private let headerView: HeaderView = HeaderView()
    private let tempView: TemperaturView = TemperaturView()
    
    override func layoutSubviews() {
        
        backgroundColor = UIColor.red
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
            "s": 30
        ]
        
        let constraintsAsStrings: [String] = [
            "H:|-s-[header]-s-|",
            "H:|-s-[temp]-s-|",
            "V:|-s-[header]-s-[temp]-(>=s)-|"
        ]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: metrics, views: views))
    }
    
    func handleNewWeatherData(_ weather: ApiResponse){
        headerView.handleNewWeatherData(weather)
    }
    
}
