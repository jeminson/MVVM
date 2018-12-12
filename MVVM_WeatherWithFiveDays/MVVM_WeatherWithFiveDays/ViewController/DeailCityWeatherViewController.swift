//
//  DeailCityWeatherViewController.swift
//  MVVM_WeatherWithFiveDays
//
//  Created by Je Min Son on 12/12/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import UIKit
import Kingfisher

class DetailCityWeatherViewController: UIViewController {

    @IBOutlet weak var currentWeatherIconImgView: UIImageView!
    @IBOutlet weak var selectedCityImgView: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var currentWeatherTempLabel: UILabel!
    @IBOutlet weak var currentWeatherWindSpeedLabel: UILabel!
    
    
    let cityViewModel = CityViewModel()
    let weatherViewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = cityViewModel.allCityModels[0].cityName
     
        getSelectedCityWeahter()
        getCurrentCityByName(currentCityName: cityViewModel.allCityModels[0].cityName!)
    }
}

extension DetailCityWeatherViewController {
    func getCurrentCityByName(currentCityName: String) {
        cityViewModel.getCityImage(cityName: currentCityName) { (cityImgUrl) in
            DispatchQueue.main.async {
                self.selectedCityImgView.kf.setImage(with: cityImgUrl as? Resource)
            }
        }
    }
    
    func getSelectedCityWeahter() {
        weatherViewModel.getCurrentCityWeatherByCoordinate(lat: cityViewModel.allCityModels[0].latitude!, long: cityViewModel.allCityModels[0].longitude!) { (weatherModel) in
            
            DispatchQueue.main.async {
                self.currentWeatherLabel.text = self.weatherViewModel.weatherInfo[0].weatherMain!
                self.currentWeatherTempLabel.text = String(self.weatherViewModel.weatherInfo[0].temp!)
                self.currentWeatherWindSpeedLabel.text = String(self.weatherViewModel.weatherInfo[0].windSpeed!)
                self.currentWeatherIconImgView.kf.setImage(with: self.weatherViewModel.weatherInfo[0].weatherIcon)
            }
            
        }
        
    }
}
