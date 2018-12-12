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
        
        
        let firstDayWeatherModel = WeatherModel.init(id: cityId, cityName: name, latitude: coordinate!["lat"], longitude: coordinate!["lon"], temp: firstDayWeatherTemp, weatherMain: firstDayWeatherMain, windSpeed: firstDayWindSpeed, weatherIcon: firstDayWeatherIconUrl)

        weatherInfoDict.append(firstDayWeatherModel)
//
        let secondDayWeatherList = list![8]
        let secondDayWeatherTime = secondDayWeatherList["dt_txt"] as? String
        print("Time: \(secondDayWeatherTime!)")
        let secondDayWeatherMainDict = secondDayWeatherList["main"] as? Dictionary<String, Any>
        let secondDayWeatherTemp = secondDayWeatherMainDict!["temp"] as? Double
        print("Temp: \(secondDayWeatherTemp!)")
        let secondDayWeatherArray = secondDayWeatherList["weather"] as? Array<Dictionary<String, Any>>
        let secondDayWeatherFirstArraayIndex = secondDayWeatherArray![0]
        let secondDayWeatherMain = secondDayWeatherFirstArraayIndex["main"] as? String
        print("Weahter: \(secondDayWeatherMain!)")
        let secondDayWeatherIcon = secondDayWeatherFirstArraayIndex["icon"] as? String
        print("Icon: \(secondDayWeatherIcon!)")
        let secondDayWeatherIconUrl = URL(string: "\(weatherIconString)\(secondDayWeatherIcon!).png")
        print("Icon Url: \(secondDayWeatherIconUrl!)")
        let secondDayWeatherWind = secondDayWeatherList["wind"] as? Dictionary<String, Any>
        let secondDayWindSpeed = secondDayWeatherWind!["speed"] as? Double
        print("Speed: \(secondDayWindSpeed!)")
        
        let secondDayWeatherModel = WeatherModel.init(id: cityId, cityName: name, latitude: coordinate!["lat"], longitude: coordinate!["lon"], temp: secondDayWeatherTemp, weatherMain: secondDayWeatherMain, windSpeed: secondDayWindSpeed, weatherIcon: secondDayWeatherIconUrl)
        
        weatherInfoDict.append(secondDayWeatherModel)
        

        let thirdDayWeatherList = list![16]
        let thirdDayWeatherTime = thirdDayWeatherList["dt_txt"] as? String
        print("Time: \(thirdDayWeatherTime!)")
        let thirdDayWeatherMainDict = thirdDayWeatherList["main"] as? Dictionary<String, Any>
        let thirdDayWeatherTemp = thirdDayWeatherMainDict!["temp"] as? Double
        print("Temp: \(thirdDayWeatherTemp!)")
        let thirdDayWeatherArray = thirdDayWeatherList["weather"] as? Array<Dictionary<String, Any>>
        let thirdDayWeatherFirstArraayIndex = thirdDayWeatherArray![0]
        let thirdDayWeatherMain = thirdDayWeatherFirstArraayIndex["main"] as? String
        print("Weahter: \(thirdDayWeatherMain!)")
        let thirdDayWeatherIcon = thirdDayWeatherFirstArraayIndex["icon"] as? String
        print("Icon: \(thirdDayWeatherIcon!)")
        let thirdDayWeatherIconUrl = URL(string: "\(weatherIconString)\(thirdDayWeatherIcon!).png")
        print("Icon Url: \(thirdDayWeatherIconUrl!)")
        let thirdDayWeatherWind = thirdDayWeatherList["wind"] as? Dictionary<String, Any>
        let thirdDayWindSpeed = thirdDayWeatherWind!["speed"] as? Double
        print("Speed: \(thirdDayWindSpeed!)")
        
        let thirdDayWeatherModel = WeatherModel.init(id: cityId, cityName: name, latitude: coordinate!["lat"], longitude: coordinate!["lon"], temp: thirdDayWeatherTemp, weatherMain: thirdDayWeatherMain, windSpeed: thirdDayWindSpeed, weatherIcon: thirdDayWeatherIconUrl)
        
        weatherInfoDict.append(thirdDayWeatherModel)
        
        
    
        let fourthDayWeatherList = list![16]
        let fourthDayWeatherTime = fourthDayWeatherList["dt_txt"] as? String
        print("Time: \(fourthDayWeatherTime!)")
        let fourthDayWeatherMainDict = fourthDayWeatherList["main"] as? Dictionary<String, Any>
        let fourthDayWeatherTemp = fourthDayWeatherMainDict!["temp"] as? Double
        print("Temp: \(fourthDayWeatherTemp!)")
        let fourthDayWeatherArray = fourthDayWeatherList["weather"] as? Array<Dictionary<String, Any>>
        let fourthDayWeatherFirstArraayIndex = fourthDayWeatherArray![0]
        let fourthDayWeatherMain = fourthDayWeatherFirstArraayIndex["main"] as? String
        print("Weahter: \(fourthDayWeatherMain!)")
        let fourthDayWeatherIcon = fourthDayWeatherFirstArraayIndex["icon"] as? String
        print("Icon: \(fourthDayWeatherIcon!)")
        let fourthDayWeatherIconUrl = URL(string: "\(weatherIconString)\(fourthDayWeatherIcon!).png")
        print("Icon Url: \(fourthDayWeatherIconUrl!)")
        let fourthDayWeatherWind = fourthDayWeatherList["wind"] as? Dictionary<String, Any>
        let fourthDayWindSpeed = fourthDayWeatherWind!["speed"] as? Double
        print("Speed: \(fourthDayWindSpeed!)")
        
        let fourthDayWeatherModel = WeatherModel.init(id: cityId, cityName: name, latitude: coordinate!["lat"], longitude: coordinate!["lon"], temp: fourthDayWeatherTemp, weatherMain: fourthDayWeatherMain, windSpeed: fourthDayWindSpeed, weatherIcon: fourthDayWeatherIconUrl)
        
        weatherInfoDict.append(fourthDayWeatherModel)

        
        
        let fifthDayWeatherList = list![16]
        let fifthDayWeatherTime = fifthDayWeatherList["dt_txt"] as? String
        print("Time: \(fifthDayWeatherTime!)")
        let fifthDayWeatherMainDict = fifthDayWeatherList["main"] as? Dictionary<String, Any>
        let fifthDayWeatherTemp = fifthDayWeatherMainDict!["temp"] as? Double
        print("Temp: \(fifthDayWeatherTemp!)")
        let fifthDayWeatherArray = fifthDayWeatherList["weather"] as? Array<Dictionary<String, Any>>
        let fifthDayWeatherFirstArraayIndex = fifthDayWeatherArray![0]
        let fifthDayWeatherMain = fifthDayWeatherFirstArraayIndex["main"] as? String
        print("Weahter: \(fourthDayWeatherMain!)")
        let fifthDayWeatherIcon = fifthDayWeatherFirstArraayIndex["icon"] as? String
        print("Icon: \(fifthDayWeatherIcon!)")
        let fifthDayWeatherIconUrl = URL(string: "\(weatherIconString)\(fifthDayWeatherIcon!).png")
        print("Icon Url: \(fifthDayWeatherIconUrl!)")
        let fifthDayWeatherWind = fifthDayWeatherList["wind"] as? Dictionary<String, Any>
        let fifthDayWindSpeed = fifthDayWeatherWind!["speed"] as? Double
        print("Speed: \(fifthDayWindSpeed!)")
        
        let fifthDayWeatherModel = WeatherModel.init(id: cityId, cityName: name, latitude: coordinate!["lat"], longitude: coordinate!["lon"], temp: fifthDayWeatherTemp, weatherMain: fifthDayWeatherMain, windSpeed: fifthDayWindSpeed, weatherIcon: fifthDayWeatherIconUrl)
        
        weatherInfoDict.append(fifthDayWeatherModel)
        
        
        
        return weatherInfoDict
    }
}
