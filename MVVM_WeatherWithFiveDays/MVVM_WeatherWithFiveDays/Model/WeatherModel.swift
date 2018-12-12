//
//  WeatherModel.swift
//  MVVM_WeatherWithFiveDays
//
//  Created by Je Min Son on 12/12/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import Foundation

struct WeatherModel {
    var id: Int?
    var cityName: String?
    var latitude: Double?
    var longitude: Double?
    
    var temp : Double?
    var weatherMain: String?
    var windSpeed: Double?
    var weatherIcon: URL?
    var time: String?
    
}
