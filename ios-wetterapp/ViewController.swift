//
//  ViewController.swift
//  ios-wetterapp
//
//  Created by admin on 04.01.24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let weather = try! PirateWeather.getInstance()
        while(true) {
            weather.fetchWeatherData()
            Thread.sleep(forTimeInterval: 5.0)
        }
    }


}

