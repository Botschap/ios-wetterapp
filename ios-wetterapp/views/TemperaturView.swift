//
//  TemperaturView.swift
//  ios-wetterapp
//
//  Created by admin on 17.02.24.
//

import Foundation
import UIKit

class TemperaturView : UIView {
    
    let temperatureLabel: UILabel = UILabel()
    let minMaxView: TempMinMaxView = TempMinMaxView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 25)
        temperatureLabel.text = "12 °C"
        temperatureLabel.backgroundColor = UIColor.white
        
        addSubview(temperatureLabel)
        addSubview(minMaxView)
        
        //needs to be set to disable autoresizing for standard componentes
        disableAutoresizingMaskConstraints()
        computeLayout()
    }
    
    func computeLayout(){
        
        let views: [String:Any] = [
            "temp": temperatureLabel,
            "minMax": minMaxView
        ]
        let metrics: [String:Int] = [
            "s": 20,
            "m": 60
        ]
        let constraintsAsStrings: [String] = [
            "H:[temp]",
            "H:|-m-[minMax]-m-|",
            "V:|-[temp]-[minMax]-|",
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: metrics, views: views))
        // Center the view both horizontally and vertically
        temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
       // minMaxView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
}
