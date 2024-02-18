//
//  Extensions.swift
//  ios-wetterapp
//
//  Created by admin on 17.02.24.
//

import Foundation
import UIKit

extension UIView {
    
    func disableAutoresizingMaskConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        for v in self.subviews {
            v.disableAutoresizingMaskConstraints()
        }
    }

}

extension NSLayoutConstraint {
    class func constraints(withVisualFormats rules: [String],
                           opts: NSLayoutConstraint.FormatOptions = [],
                           metrics: [String:Any]?, views: [String:Any]) -> [NSLayoutConstraint]{
        var res: [NSLayoutConstraint] = []
        for rule in rules {
            res.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: rule, options: opts, metrics: metrics, views: views))
        }
        return res
    }
}

protocol WeatherDataHandler {
    func handleNewWeatherData(_ weather: ApiResponse)
}

protocol WeatherDataDetailHandler {
    func handleNewWeatherData(_ weather: Forecast)
}

protocol WeatherDataForecastHandler {
    func handleNewWeatherData(_ weather: [Forecast])
}
