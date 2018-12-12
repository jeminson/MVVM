//
//  WeatherAPIHandler.swift
//  MVVM_WeatherWithFiveDays
//
//  Created by Je Min Son on 12/12/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import Foundation

let weatherAPIString = "https://api.openweathermap.org/data/2.5/forecast?"
let weatherAPIKey = "e559c1f4452715302985fd818a67eced"

// https://api.openweathermap.org/data/2.5/forecast?lat=35&lon=139&appid=e559c1f4452715302985fd818a67eced

class WeatherAPIHandler: NSObject {
    // Singleton class
    static let sharedInstance = WeatherAPIHandler()
    private override init() {}
    
    func getWeatherInformationByCoordinate(lat: Double, long: Double, completion: @escaping ([WeatherModel]) -> ()) {
        DispatchQueue.global().async {
            guard let url = URL(string: "\(weatherAPIString)lat=\(lat)&lon=\(long)&appid=\(weatherAPIKey)") else {return}
            
            let task = URLSession.shared.dataTask(with: url) { (data, reponse, error) in
                if error == nil {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any> {
                            
                            let weatherModel = WeatherParser.parserWeatherInformation(weatherInfoResponseObj: jsonResponse)
                            
                            completion(weatherModel)
                        } else {
                            completion([])
                        }
                    } catch {
                        completion([])
                    }
                }
            }
            task.resume()
        }
        
    }

}
