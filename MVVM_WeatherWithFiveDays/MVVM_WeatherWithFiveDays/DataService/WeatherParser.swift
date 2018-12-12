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
        
        let list = weatherInfoResponseObj["list"] as? Array<Dictionary<String, Any>>
        let firstDayWeatherList = list![0]
        let firstDayWeatherTime = firstDayWeatherList["dt_txt"] as? String
        print("Time: \(firstDayWeatherTime!)")
        let firstDayWeatherMainDict = firstDayWeatherList["main"] as? Dictionary<String, Any>
        let firstDayWeatherTemp = firstDayWeatherMainDict!["temp"] as? Double
        print("Temp: \(firstDayWeatherTemp!)")
        let firstDayWeatherArray = firstDayWeatherList["weather"] as? Array<Dictionary<String, Any>>
        let firstDayWeatherFirstArraayIndex = firstDayWeatherArray![0]
        let firstDayWeatherMain = firstDayWeatherFirstArraayIndex["main"] as? String
        print("Weahter: \(firstDayWeatherMain!)")
        let firstDayWeatherIcon = firstDayWeatherFirstArraayIndex["icon"] as? String
        print("Icon: \(firstDayWeatherIcon!)")
        let firstDayWeatherIconUrl = URL(string: "\(weatherIconString)\(firstDayWeatherIcon!).png")
        print("Icon Url: \(firstDayWeatherIconUrl!)")
        let firstDayWeatherWind = firstDayWeatherList["wind"] as? Dictionary<String, Any>
        let firstDayWindSpeed = firstDayWeatherWind!["speed"] as? Double
        print("Speed: \(firstDayWindSpeed!)")
        
        
        let firstDayWeatherModel = WeatherModel.init(id: cityId, cityName: name, latitude: coordinate!["lat"], longitude: coordinate!["lon"], firstDayTemp: firstDayWeatherTemp, firstDayWeatherMain: firstDayWeatherMain, firstDayWindSpeed: firstDayWindSpeed, firstDayWeatherIcon: firstDayWeatherIconUrl)

        weatherInfoDict.append(firstDayWeatherModel)
//
//        let secondDayWeatherInfo = list![8] as? Dictionary<String, Any>
//        let thirdDayWeatherInfo = list![16] as? Dictionary<String, Any>
//        let fourthDayWeatherInfo = list![24] as? Dictionary<String, Any>
//        let fifthDayWeatherInfo = list![32] as? Dictionary<String, Any>
        
        
        
        return weatherInfoDict
    }
}
