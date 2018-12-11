//
//  WeatherViewModel.swift
//  MVVM_WeatherApp
//
//  Created by Je Min Son on 12/10/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import Foundation

class WeatherViewModel {
    
    var weatherInfo : [WeatherModel] = []
    
    func getCurrentCityWeatherByCoordinate(lat: Double, long: Double, completion: @escaping (Any?) -> ()) {
        WeatherAPIHandler.sharedInstance.getWeatherInformationByCoordinate(lat: lat, long: long) { (weatherModel) in
            
            completion(weatherModel)
        }
    }
    

}
