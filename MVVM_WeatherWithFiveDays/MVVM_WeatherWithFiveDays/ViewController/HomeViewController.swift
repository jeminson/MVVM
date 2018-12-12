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

    
    @IBOutlet weak var fifthDayWeatherLabel: UILabel!
    @IBOutlet weak var fifthDayWeatherIconImgView: UIImageView!
    
    
    @IBOutlet weak var fourthDayWeatherLabel: UILabel!
    @IBOutlet weak var fourthDayWeatherIconImgView: UIImageView!
    
    
    @IBOutlet weak var thirdDayWeatherLabel: UILabel!
    @IBOutlet weak var thirdDayWeatherIconImgView: UIImageView!
    
    
    @IBOutlet weak var secondDayWeatherLabel: UILabel!
    @IBOutlet weak var secondDayWeatherIconImgView: UIImageView!
    
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
                self.currentWeatherLabel.text = self.weatherViewModel.weatherInfo[0].weatherMain!
                self.currentWeatherTempLabel.text = String(self.weatherViewModel.weatherInfo[0].temp!)
                self.currentWeatherWindSpeedLabel.text = String(self.weatherViewModel.weatherInfo[0].windSpeed!)
                
                self.currentWeatherIconImgView.kf.setImage(with: self.weatherViewModel.weatherInfo[0].weatherIcon)
                
                
                self.secondDayWeatherLabel.text = self.weatherViewModel.weatherInfo[1].weatherMain!
                self.secondDayWeatherIconImgView.kf.setImage(with: self.weatherViewModel.weatherInfo[1].weatherIcon)
                
                self.thirdDayWeatherLabel.text = self.weatherViewModel.weatherInfo[2].weatherMain!
                self.thirdDayWeatherIconImgView.kf.setImage(with: self.weatherViewModel.weatherInfo[2].weatherIcon)
                
                self.fourthDayWeatherLabel.text = self.weatherViewModel.weatherInfo[3].weatherMain!
                self.fourthDayWeatherIconImgView.kf.setImage(with: self.weatherViewModel.weatherInfo[3].weatherIcon)
                
                self.fifthDayWeatherLabel.text = self.weatherViewModel.weatherInfo[4].weatherMain!
                self.fifthDayWeatherIconImgView.kf.setImage(with: self.weatherViewModel.weatherInfo[4].weatherIcon)
            }
            
        }
    }
}
