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
    
    @IBOutlet weak var secondDayTimeLabel: UILabel!
    @IBOutlet weak var secondDayWeatherIconImgView: UIImageView!
    @IBOutlet weak var secondDayWeatherLabel: UILabel!
    
    @IBOutlet weak var thirdDayTimeLabel: UILabel!
    @IBOutlet weak var thirdDayWeatherIconImgView: UIImageView!
    @IBOutlet weak var thirdDayWeatherLabel: UILabel!
    
    
    @IBOutlet weak var fourthDayTimeLabel: UILabel!
    @IBOutlet weak var fourthDayWeatherIconImgView: UIImageView!
    @IBOutlet weak var fourthDayWeatherLabel: UILabel!
    
    
    @IBOutlet weak var fifthDayTimeLabel: UILabel!
    @IBOutlet weak var fifthDayWeatherIconImgView: UIImageView!
    @IBOutlet weak var fifthDayWeatherLabel: UILabel!
    
    
    
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
                
                self.secondDayWeatherLabel.text = self.weatherViewModel.weatherInfo[8].weatherMain!
                self.secondDayTimeLabel.text = String(self.weatherViewModel.weatherInfo[8].time!)
                self.secondDayWeatherIconImgView.kf.setImage(with: self.weatherViewModel.weatherInfo[8].weatherIcon)
                
                self.thirdDayWeatherLabel.text = self.weatherViewModel.weatherInfo[16].weatherMain!
                self.thirdDayTimeLabel.text = String(self.weatherViewModel.weatherInfo[16].time!)
                self.thirdDayWeatherIconImgView.kf.setImage(with: self.weatherViewModel.weatherInfo[16].weatherIcon)
                
                self.fourthDayWeatherLabel.text = self.weatherViewModel.weatherInfo[24].weatherMain!
                self.fourthDayTimeLabel.text = String(self.weatherViewModel.weatherInfo[24].time!)
                self.fourthDayWeatherIconImgView.kf.setImage(with: self.weatherViewModel.weatherInfo[24].weatherIcon)
                
                self.fifthDayWeatherLabel.text = self.weatherViewModel.weatherInfo[32].weatherMain!
                self.fifthDayTimeLabel.text = String(self.weatherViewModel.weatherInfo[32].time!)
                self.fifthDayWeatherIconImgView.kf.setImage(with: self.weatherViewModel.weatherInfo[32].weatherIcon)
            }
            
        }
        
    }
}
