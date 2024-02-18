//
//  DailyView.swift
//  ios-wetterapp
//
//  Created by admin on 18.02.24.
//

import Foundation
import UIKit

class DailyView: UIView, WeatherDataHandler {
    
    var smallDetailViews: [SmallDetailView] = [SmallDetailView(), SmallDetailView(), SmallDetailView(), SmallDetailView(), SmallDetailView()]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for view in smallDetailViews {
            view.index = smallDetailViews.firstIndex(of: view)!
            addSubview(view)
        }
        
        disableAutoresizingMaskConstraints()
        computeLayout()
    }
    
    func computeLayout(){
        let views: [String:Any] = [
            "one": smallDetailViews[1],
            "two": smallDetailViews[2],
            "three": smallDetailViews[3],
            "four": smallDetailViews[4],
            "zero": smallDetailViews[0],
        ]
        let metrics: [String:Int] = [
            "s": 10,
        ]
        let constraintsAsStrings: [String] = [
            "H:|-[zero]-[one]-[two]-[three]-[four]-|",
            "V:|-[zero]-|",
            "V:|-[one]-|",
            "V:|-[two]-|",
            "V:|-[three]-|",
            "V:|-[four]-|",
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: metrics, views: views))
    }
    
    
    func handleNewWeatherData(_ weather: ApiResponse) {
        //todo
        for subview in subviews {
            if let handler = subview as? WeatherDataHandler {
                handler.handleNewWeatherData(weather)
            }
        }
    }
    
}
