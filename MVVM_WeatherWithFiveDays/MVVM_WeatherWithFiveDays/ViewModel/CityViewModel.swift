//
//  CityViewModel.swift
//  MVVM_WeatherWithFiveDays
//
//  Created by Je Min Son on 12/11/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import Foundation

class CityViewModel {
    
    var allCityModels : [CityModel] = []
    var unSortedAllCityModels : [CityModel] = []
    var selectedCitiesModels : [CityModel] = []
    
    func getAllCityInfo(completion: @escaping ([CityModel]) -> ()) {
        CityAPIHandler.sharedInstance.getCityInformationFromJSON { (cityModels) in
            self.allCityModels = cityModels
            self.unSortedAllCityModels = cityModels
            
            completion(self.allCityModels)
        }
    }
    
    func getAllCityRowCount() -> Int {
        return allCityModels.count
    }
    
    func getAllCityIndex(atIndex: Int) -> CityModel {
        return allCityModels[atIndex]
    }
    func getCitySortedByCityName(searchBarText: String) {
        DispatchQueue.main.async {
            self.allCityModels = self.unSortedAllCityModels.filter({$0.cityName!.uppercased().contains(searchBarText)})
        }
    }
    func getCitySortedByCityNameCancel() {
        allCityModels = unSortedAllCityModels
    }
    func setSelectedCity(selectedCities: CityModel) {
        selectedCitiesModels.append(selectedCities)
    }
    func getSelectedCityCount() -> Int {
        return selectedCitiesModels.count
    }
    func getSelectedCity(atIndex: Int) -> CityModel {
        return selectedCitiesModels[atIndex]
    }
    
    
    func getCityImage(cityName: String, completion: @escaping (Any?) -> ()) {
        
        CityAPIHandler.sharedInstance.getCityImageFromUnsplash(cityName: cityName) { (cityImgUrl) in
            completion(cityImgUrl)
        }
    }
}
