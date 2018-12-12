//
//  CityImageParser.swift
//  MVVM_WeatherWithFiveDays
//
//  Created by Je Min Son on 12/12/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import Foundation

class CityParser {
    
    class func parseCityInformation(cityInfoResponseObj: Array<Dictionary<String, Any>>) -> [CityModel] {
        var cityInfoArray: [CityModel] = []
        
        for city in cityInfoResponseObj {
            let coordinate = city["coord"] as? [String: Double]
            if let id = city["id"] as? Int?, let name = city["name"] as? String?, let country = city["country"] as? String, let lat = coordinate?["lat"], let long = coordinate?["lon"] {
                let cityModel = CityModel.init(cityId: id, cityName: name, country: country, latitude: lat, longitude: long)
                
                cityInfoArray.append(cityModel)
            }
        }
        
        return cityInfoArray
    }
    
    class func parseCityImageResponse(cityImgResponseObj: Dictionary<String, Any>) -> String {
        var imgUrl : String?
        
        for item in cityImgResponseObj {
            if item.key == "results" {
                let resultDict = item.value as! Array<Dictionary<String, Any>>
                for url in resultDict[0] {
                    if url.key == "urls" {
                        let imgs = url.value as! Dictionary<String, Any>
                        for img in imgs {
                            if img.key == "small" {
                                imgUrl = img.value as? String
                            }
                        }
                    }
                }
            }
        }
        
        return imgUrl ?? ""
    }
    
}
