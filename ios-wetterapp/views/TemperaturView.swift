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
    let tempMinLabel: UILabel = UILabel()
    let tempMaxLabel: UILabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 25)
        temperatureLabel.text = "12 °C"
        tempMaxLabel.font = UIFont.systemFont(ofSize: 18)
        tempMaxLabel.text = "16 °C"
        tempMinLabel.font = UIFont.systemFont(ofSize: 18)
        tempMinLabel.text = "10 °C"
        temperatureLabel.backgroundColor = UIColor.white
        
        addSubview(temperatureLabel)
        addSubview(tempMinLabel)
        addSubview(tempMaxLabel)
        
        disableAutoresizingMaskConstraints()
        computeLayout()
    }
    
    func computeLayout(){
        
        let views: [String:Any] = [
            "temp": temperatureLabel,
            "min": tempMinLabel,
            "max": tempMaxLabel
        ]
        let metrics: [String:Int] = [
            "s": 20
        ]
        let constraintsAsStrings: [String] = [
           "H:|-s-[min]-s-[max]-s-|",
           "V:|-[temp]-[min]-|",
           "V:|-[temp]-[max]-|"
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[temp]-|", options: [.alignAllCenterX], metrics: metrics, views: views))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: metrics, views: views))
        
    }
    
}
