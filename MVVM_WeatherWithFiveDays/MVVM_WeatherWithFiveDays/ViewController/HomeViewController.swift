//
//  ViewController.swift
//  MVVM_WeatherWithFiveDays
//
//  Created by Je Min Son on 12/10/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {

    @IBOutlet weak var currentCityImgView: UIImageView!
    let cityViewModel = CityViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For now, Hard code to <Chicago> since <St. Charles> is not working "
        getCurrentCityByName(currentCityName: "Chicago")
    }
    
    func getCurrentCityByName(currentCityName: String) {
        cityViewModel.getCityImage(cityName: currentCityName) { (cityImgUrl) in
            DispatchQueue.main.async {
                self.currentCityImgView.kf.setImage(with: cityImgUrl as? Resource)
            }
        }
    }
    
}

