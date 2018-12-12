//
//  WeatherParser.swift
//  MVVM_WeatherWithFiveDays
//
//  Created by Je Min Son on 12/12/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import Foundation

let weatherIconString = "http://openweathermap.org/img/w/"

class WeatherParser {
    class func parserWeatherInformation(weatherInfoResponseObj: Dictionary<String, Any>) -> [WeatherModel] {
        var weatherInfoDict: [WeatherModel] = []
        
        let city = weatherInfoResponseObj["city"] as? Dictionary<String, Any>
        let cityId = city!["id"] as? Int
        let name = city!["name"] as? String
        let coordinate = city!["coord"] as? Dictionary<String, Double>
        
        for item in (weatherInfoResponseObj["list"] as? Array<Dictionary<String, Any>>)! {
            let time = item["dt_txt"] as? String
            print("Time: \(time!)")
            let weatherMainDict = item["main"] as? Dictionary<String, Any>
            let weatherTemp = weatherMainDict!["temp"] as? Double
            print("Temp: \(weatherTemp!)")
            let weatherArray = item["weather"] as? Array<Dictionary<String, Any>>
            let weatherFirstArrayIndex = weatherArray![0]
            let weatherMain = weatherFirstArrayIndex["main"] as? String
            print("Weahter: \(weatherMain!)")
            let weatherIcon = weatherFirstArrayIndex["icon"] as? String
            print("Icon: \(weatherIcon!)")
            let weatherIconUrl = URL(string: "\(weatherIconString)\(weatherIcon!).png")
            print("Icon Url: \(weatherIconUrl!)")
            let weatherWind = item["wind"] as? Dictionary<String, Any>
            let windSpeed = weatherWind!["speed"] as? Double
            print("Speed: \(windSpeed!)")
            
            let weatherModel = WeatherModel.init(id: cityId, cityName: name, latitude: coordinate!["lat"], longitude: coordinate!["lon"], temp: weatherTemp, weatherMain: weatherMain, windSpeed: windSpeed, weatherIcon: weatherIconUrl, time: time)
            
            weatherInfoDict.append(weatherModel)
        }
        return weatherInfoDict
    }
}
