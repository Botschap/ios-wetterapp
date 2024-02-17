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
    let demoicon: UIImageView = UIImageView(image: UIImage(systemName: "sun.max.fill"))
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cityName.backgroundColor = UIColor.white
        cityName.font = UIFont.boldSystemFont(ofSize: 25)
        addSubview(cityName)
        addSubview(demoicon)
        //needs to be set to disable autoresizing for standard componentes
        disableAutoresizingMaskConstraints()
        computeLayout()
        
    }
    
    func computeLayout() {
        let views: [String:Any] = [
            "city": cityName,
            "icon": demoicon
        ]
        let metrics: [String:Int] = [
            "s": 20,
        ]
        let constraintsAsStrings: [String] = [
            "H:|-s-[city]-(>=s)-[icon(>=60)]-(s)-|",
            "V:|-s-[icon(>=60)]-(>=s)-|",
            "V:|-s-[city(==icon)]-(>=s)-|"
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: metrics, views: views))
        
    }
    
    func handleNewWeatherData(_ weather: ApiResponse) {
        cityName.text = weather.city.name
        func handleNewWeatherData(_ weather: ApiResponse){
            for subview in subviews {
                if let handler = subview as? WeatherDataHandler {
                    handler.handleNewWeatherData(weather)
                }
            }
        }
        setNeedsDisplay()
    }
    
}
