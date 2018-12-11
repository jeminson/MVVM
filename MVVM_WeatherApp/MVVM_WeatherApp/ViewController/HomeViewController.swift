//
//  ViewController.swift
//  MVVM_WeatherApp
//
//  Created by Je Min Son on 12/10/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherMainLabel: UILabel!
    
    let weatherViewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getCurrentCityWeather()
    }

    func getCurrentCityWeather() {
        weatherViewModel.getCurrentCityWeatherByCoordinate(lat: 41.87, long: -87.63) { (weather) in
            self.weatherViewModel.weatherInfo = weather as! [WeatherModel]
            
            DispatchQueue.main.async {
                self.cityNameLabel.text = self.weatherViewModel.weatherInfo[0].cityName!
                self.weatherMainLabel.text = self.weatherViewModel.weatherInfo[0].weatherMain!
            }
        }
    }

}

