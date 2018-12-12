//
//  WeatherViewModel.swift
//  MVVM_WeatherWithFiveDays
//
//  Created by Je Min Son on 12/12/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import Foundation

class WeatherViewModel {
    
    var weatherInfo : [WeatherModel] = []
    
    func getCurrentCityWeatherByCoordinate(lat: Double, long: Double, completion: @escaping ([WeatherModel]) -> ()) {
        WeatherAPIHandler.sharedInstance.getWeatherInformationByCoordinate(lat: lat, long: long) { (weatherModel) in
            self.weatherInfo = weatherModel
            
            completion(weatherModel)
        }
    }
    
}
