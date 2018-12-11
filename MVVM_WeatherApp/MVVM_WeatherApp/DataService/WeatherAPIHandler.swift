//
//  WeatherAPIHandler.swift
//  MVVM_WeatherApp
//
//  Created by Je Min Son on 12/10/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import Foundation

let weatherAPIString = "https://api.openweathermap.org/data/2.5/weather?"
let weatherAPIKey = "e559c1f4452715302985fd818a67eced"

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
                            
                            let coordinate = jsonResponse["coord"] as? [String:Any]
                            let weather = jsonResponse["weather"] as? [[String:Any]]
                            if let id = jsonResponse["id"] as? Int, let cityName = jsonResponse["name"] as? String, let lat = coordinate?["lat"], let long = coordinate?["lon"], let weatherMain = weather?[0]["main"], let weatherIcon = weather?[0]["icon"] {
                                
                                let weatherInfo = WeatherModel.init(id: id,
                                                                    cityName: cityName,
                                                                    latitude: lat as? Double,
                                                                    longitude: long as? Double,
                                                                    weatherMain: weatherMain as? String,
                                                                    weatherIcon: weatherIcon as? String)
                                
                                completion([weatherInfo])
                            }
                            
                        } else {
                            completion([])
                        }
                    } catch {
                        completion([])
                    } // End do catch
                } // End if error
            } // End let task
            task.resume()
        }
    }
}
