//
//  WeatherModel.swift
//  ios-wetterapp
//
//  Created by admin on 11.01.24.
//

import Foundation

class WeatherModel {
    
    var data: WeatherResponse? {
        get {
            return _data
        }
        set {
          _data = newValue
        }
    }
    
    private var _data: WeatherResponse?
    
}
