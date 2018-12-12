//
//  CityAPIHandler.swift
//  MVVM_WeatherWithFiveDays
//
//  Created by Je Min Son on 12/11/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import Foundation

let cityImgURLString = "https://api.unsplash.com/search/photos?query="
let cityImgAPIKey = "90f584fb154bf3beebaa6273f12402d7f138f8d556ac1b61b27a9f1fb6b31110"

class CityAPIHandler: NSObject {
    // Singleton class
    static let sharedInstance = CityAPIHandler()
    private override init() {}
    
    func getCityInformationFromJSON(completion: @escaping ([CityModel]) -> ()) {
        DispatchQueue.global().async {
            if let url = Bundle.main.url(forResource: "city.list", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? Array<Dictionary<String, Any>> {
                        
                        let cityModel = CityParser.parseCityInformation(cityInfoResponseObj: jsonResponse)
                        
                        completion(cityModel)
                    } else {
                        completion([])
                    }
                } catch {
                    completion([])
                }
            }
        }
    }
    
    
    func getCityImageFromUnsplash(cityName: String, completion: @escaping (Any?) -> ()) {
        guard let url = URL(string: "\(cityImgURLString)\(cityName)&client_id=\(cityImgAPIKey)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, reponse, error) in
            if error == nil {
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any> {
                        
                        let cityImgUrlString = CityParser.parseCityImageResponse(cityImgResponseObj: jsonResponse)
                        let cityImgUrl = URL(string: "\(cityImgUrlString).png")
                        completion(cityImgUrl)
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
