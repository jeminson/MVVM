//
//  ViewController.swift
//  MVVM_WeatherWithFiveDays
//
//  Created by Je Min Son on 12/10/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {

    @IBOutlet weak var currentWeatherIconImgView: UIImageView!
    @IBOutlet weak var currentWeatherWindSpeedLabel: UILabel!
    @IBOutlet weak var currentWeatherTempLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var currentCityNameLabel: UILabel!
    @IBOutlet weak var currentCityImgView: UIImageView!

    let cityViewModel = CityViewModel()
    let weatherViewModel = WeatherViewModel()
    
    let currentCity : String = "Chicago"
    let currentCityLatitude : Double = 41.87
    let currentCityLongitude : Double = -87.63

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For now, Hard code to <Chicago> since <St. Charles> is not working "
        currentCityNameLabel.text = currentCity
        getCurrentCityByName(currentCityName: currentCity)
        getCurrentCityWeather(currentCityLat: currentCityLatitude, currentCitylong: currentCityLongitude)
    }
}

extension HomeViewController {
    func getCurrentCityByName(currentCityName: String) {
        cityViewModel.getCityImage(cityName: currentCityName) { (cityImgUrl) in
            DispatchQueue.main.async {
                self.currentCityImgView.kf.setImage(with: cityImgUrl as? Resource)
            }
        }
    }
    func getCurrentCityWeather(currentCityLat: Double, currentCitylong: Double) {
        weatherViewModel.getCurrentCityWeatherByCoordinate(lat: currentCityLat, long: currentCitylong) { (weatherModel) in
            
            self.weatherViewModel.weatherInfo = weatherModel 
            
            DispatchQueue.main.async {
                self.currentWeatherLabel.text = self.weatherViewModel.weatherInfo[0].firstDayWeatherMain!
                self.currentWeatherTempLabel.text = String(self.weatherViewModel.weatherInfo[0].firstDayTemp!)
                self.currentWeatherWindSpeedLabel.text = String(self.weatherViewModel.weatherInfo[0].firstDayWindSpeed!)
            }
            
        }
    }
}
