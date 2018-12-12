//
//  CityViewModel.swift
//  MVVM_WeatherWithFiveDays
//
//  Created by Je Min Son on 12/11/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import Foundation

class CityViewModel {
    
    func getCityImage(cityName: String, completion: @escaping (Any?) -> ()) {
        CityAPIHandler.sharedInstance.getCityImageFromUnsplash(cityName: cityName) { (cityImgUrl) in
            completion(cityImgUrl)
        }
    }
}
