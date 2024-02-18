//
//  ForecastView.swift
//  ios-wetterapp
//
//  Created by admin on 18.02.24.
//

import Foundation
import UIKit

class ForecastView: UIView, WeatherDataHandler {
    
    //API has forecast for 5 days
    let forecastDetailViews: [ForecastDetailView] = [ForecastDetailView(), ForecastDetailView(), ForecastDetailView(), ForecastDetailView(), ForecastDetailView()]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for forecastDetailView in forecastDetailViews {
            addSubview(forecastDetailView)
        }
        
        disableAutoresizingMaskConstraints()
        computeLayout()
    }
    
    func computeLayout(){
        let views: [String:Any] = [
            "one": forecastDetailViews[1],
            "two": forecastDetailViews[2],
            "three": forecastDetailViews[3],
            "four": forecastDetailViews[4],
            "zero": forecastDetailViews[0],
        ]
        let metrics: [String:Int] = [
            "s": 10,
        ]
        let constraintsAsStrings: [String] = [
            "V:|-[zero]-s-[one]-s-[two]-s-[three]-s-[four]-|",
            "H:|-[zero]-|",
            "H:|-[one]-|",
            "H:|-[two]-|",
            "H:|-[three]-|",
            "H:|-[four]-|",
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormats: constraintsAsStrings, metrics: metrics, views: views))
        
        /*for forecastDetailView in forecastDetailViews {
            forecastDetailView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }*/
    }
    
    func handleNewWeatherData(_ weather: ApiResponse) {
        var aktDate: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        for subview in subviews {
            if let handler = subview as? WeatherDataForecastHandler {
                //find all forecasts to a certain Day
                let forecastsForAktDate = weather.list.filter{areDatesOnSameDay(aktDate, dateFormatter.date(from: $0.dt_txt))}
                handler.handleNewWeatherData(forecastsForAktDate)
                //advance day
                aktDate = aktDate.advanced(by: 24 * 60 * 60)
            }
        }
    }
    
    func areDatesOnSameDay(_ date1: Date, _ date2: Date?) -> Bool {
        if date2 == nil {
            return false
        }
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
        let components2 = calendar.dateComponents([.year, .month, .day], from: date2!)

        return components1.year == components2.year &&
               components1.month == components2.month &&
               components1.day == components2.day
    }
    
}
