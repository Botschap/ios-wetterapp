//
//  TempMinMaxView.swift
//  ios-wetterapp
//
//  Created by admin on 17.02.24.
//

import Foundation
import UIKit

class TempMinMaxView: UIView, WeatherDataHandler {
    let tempMinLabel: UILabel = UILabel()
    let tempMaxLabel: UILabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        tempMaxLabel.font = UIFont.systemFont(ofSize: 18)
        tempMinLabel.font = UIFont.systemFont(ofSize: 18)
        
        addSubview(tempMinLabel)
        addSubview(tempMaxLabel)
        
        //needs to be set to disable autoresizing for standard componentes
        disableAutoresizingMaskConstraints()
        computeLayout()
    }
    
    func computeLayout(){
        
        let views: [String:Any] = [
            "min": tempMinLabel,
            "max": tempMaxLabel
        ]
        let metrics: [String:Int] = [
            "s": 20
        ]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[min]-(>=s)-[max]-|", metrics: metrics, views: views))
    }
    
    func handleNewWeatherData(_ weather: ApiResponse) {
        tempMinLabel.text = "\(Int(weather.list[0].main.temp_min.rounded())) °C"
        tempMaxLabel.text = "\(Int(weather.list[0].main.temp_max.rounded())) °C"
        for subview in subviews {
            if let handler = subview as? WeatherDataHandler {
                handler.handleNewWeatherData(weather)
            }
        }
        setNeedsDisplay()
    }
    
}
