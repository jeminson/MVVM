//
//  ViewController.swift
//  MVVM_WeatherWithFiveDays
//
//  Created by Je Min Son on 12/10/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD

class HomeViewController: UIViewController {

    @IBOutlet weak var fifthDayWeatherLabel: UILabel!
    @IBOutlet weak var fifthDayWeatherIconImgView: UIImageView!
    @IBOutlet weak var fifthDayWeatherTimeLabel: UILabel!
    
    @IBOutlet weak var fourthDayWeatherLabel: UILabel!
    @IBOutlet weak var fourthDayWeatherIconImgView: UIImageView!
    @IBOutlet weak var fourthDayWeatherTimeLabel: UILabel!
    
    @IBOutlet weak var thirdDayWeatherLabel: UILabel!
    @IBOutlet weak var thirdDayWeatherIconImgView: UIImageView!
    @IBOutlet weak var thirdDayWeatherTimeLabel: UILabel!
    
    @IBOutlet weak var secondDayWeatherLabel: UILabel!
    @IBOutlet weak var secondDayWeatherIconImgView: UIImageView!
    @IBOutlet weak var secondDayWeatherTimeLabel: UILabel!
    
    @IBOutlet weak var currentWeatherIconImgView: UIImageView!
    @IBOutlet weak var currentWeatherWindSpeedLabel: UILabel!
    @IBOutlet weak var currentWeatherTempLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var currentCityNameLabel: UILabel!
    @IBOutlet weak var currentCityImgView: UIImageView!

    @IBOutlet weak var selectedCityTableView: UITableView!
    
    let cityViewModel = CityViewModel()
    let weatherViewModel = WeatherViewModel()
    var delegate: CityDelegate?
    
    // For now, Hard code to <Chicago> since <St. Charles> is not working"
    let currentCity : String = "Chicago"
    let currentCityLatitude : Double = 41.87
    let currentCityLongitude : Double = -87.63

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For now, Hard code to <Chicago> since <St. Charles> is not working"
        currentCityNameLabel.text = currentCity
        getCurrentCityByName(currentCityName: currentCity)
        getCurrentCityWeather(currentCityLat: currentCityLatitude, currentCitylong: currentCityLongitude)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? SearchBarViewController {
            dest.delegate = self
        }
    }
    
    // MARK: - IBAction
    @IBAction func addBarBtn(_ sender: UIBarButtonItem) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "SearchVC", sender: nil)
        }
    }
    
}

// MARK: - Functions
extension HomeViewController {
    func getCurrentCityByName(currentCityName: String) {
        cityViewModel.getCityImage(cityName: currentCityName) { (cityImgUrl) in
            DispatchQueue.main.async {
                self.currentCityImgView.kf.setImage(with: cityImgUrl as? Resource)
            }
        }
    }
    func getCurrentCityWeather(currentCityLat: Double, currentCitylong: Double) {
        weatherViewModel.getCurrentCityWeatherByCoordinate(lat: currentCityLat, long: currentCitylong) { (weatherModel) in
            
            self.weatherViewModel.weatherInfo = weatherModel 
            
            DispatchQueue.main.async {
                self.currentWeatherLabel.text = self.weatherViewModel.weatherInfo[0].weatherMain!
                self.currentWeatherTempLabel.text = String(self.weatherViewModel.weatherInfo[0].temp!)
                self.currentWeatherWindSpeedLabel.text = String(self.weatherViewModel.weatherInfo[0].windSpeed!)
                self.currentWeatherIconImgView.kf.setImage(with: self.weatherViewModel.weatherInfo[0].weatherIcon)
                
                
                self.secondDayWeatherLabel.text = self.weatherViewModel.weatherInfo[8].weatherMain!
                self.secondDayWeatherTimeLabel.text = self.weatherViewModel.weatherInfo[8].time!
                self.secondDayWeatherIconImgView.kf.setImage(with: self.weatherViewModel.weatherInfo[8].weatherIcon)
                
                self.thirdDayWeatherLabel.text = self.weatherViewModel.weatherInfo[16].weatherMain!
                self.thirdDayWeatherTimeLabel.text = self.weatherViewModel.weatherInfo[16].time!
                self.thirdDayWeatherIconImgView.kf.setImage(with: self.weatherViewModel.weatherInfo[16].weatherIcon)
                
                self.fourthDayWeatherLabel.text = self.weatherViewModel.weatherInfo[24].weatherMain!
                self.fourthDayWeatherTimeLabel.text = self.weatherViewModel.weatherInfo[24].time!
                self.fourthDayWeatherIconImgView.kf.setImage(with: self.weatherViewModel.weatherInfo[24].weatherIcon)
                
                self.fifthDayWeatherLabel.text = self.weatherViewModel.weatherInfo[32].weatherMain!
                self.fifthDayWeatherTimeLabel.text = self.weatherViewModel.weatherInfo[32].time!
                self.fifthDayWeatherIconImgView.kf.setImage(with: self.weatherViewModel.weatherInfo[32].weatherIcon)
            }
            
        }
    }
}


extension HomeViewController: CityDelegate {
    func cityValue(cityInfo: CityModel) {
        cityViewModel.setSelectedCity(selectedCities: cityInfo)
        
        DispatchQueue.main.async {
            self.selectedCityTableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityViewModel.getSelectedCityCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        
        let city = cityViewModel.getSelectedCity(atIndex: indexPath.row)
        cell.selectedCityNameLabel.text = city.cityName!
        
        cityViewModel.getCityImage(cityName: city.cityName!) { (cityImgUrl) in
            DispatchQueue.main.async {
                cell.cityImgView.kf.setImage(with: cityImgUrl as? Resource)
            }
        }

        cell.goToDetailCity.tag = indexPath.row
        cell.goToDetailCity.addTarget(self, action: #selector(viewCityDetail), for: .touchUpInside)
        
        return cell
    }
    
    @objc func viewCityDetail(_ sender: UIButton) {
        let cityDetail = cityViewModel.getSelectedCity(atIndex: sender.tag)
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "DetailCityWeatherViewController") as? DetailCityWeatherViewController {
            
            controller.cityViewModel.allCityModels = [cityDetail]
            
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
        
    }
}
