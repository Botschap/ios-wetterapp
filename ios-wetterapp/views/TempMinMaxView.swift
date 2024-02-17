//
//  TempMinMaxView.swift
//  ios-wetterapp
//
//  Created by admin on 17.02.24.
//

import Foundation
import UIKit

class TempMinMaxView: UIView {
    let tempMinLabel: UILabel = UILabel()
    let tempMaxLabel: UILabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        tempMaxLabel.font = UIFont.systemFont(ofSize: 18)
        tempMaxLabel.text = "16 °C"
        tempMinLabel.font = UIFont.systemFont(ofSize: 18)
        tempMinLabel.text = "10 °C"
        
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
}
