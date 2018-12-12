//
//  DeailCityWeatherViewController.swift
//  MVVM_WeatherWithFiveDays
//
//  Created by Je Min Son on 12/12/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import UIKit

class DetailCityWeatherViewController: UIViewController {

    let cityViewModel = CityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = cityViewModel.allCityModels[0].cityName

    }
    

}
