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
        
        
        tempMaxLabel.font = UIFont.systemFont(ofSize: 16)
        tempMinLabel.font = UIFont.systemFont(ofSize: 16)
        tempMaxLabel.textAlignment = NSTextAlignment.center
        tempMinLabel.textAlignment = NSTextAlignment.center
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
            "s": 30
        ]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[min]-s-[max]-|", metrics: metrics, views: views))
    }
    
    func handleNewWeatherData(_ weather: ApiResponse) {
        tempMinLabel.text = "T: \(Int(weather.list[0].main.temp_min.rounded()))°"
        tempMaxLabel.text = "H: \(Int(weather.list[0].main.temp_max.rounded()))°"
    }
    
}
