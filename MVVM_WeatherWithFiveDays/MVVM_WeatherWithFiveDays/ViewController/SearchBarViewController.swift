//
//  SearchBarViewController.swift
//  MVVM_WeatherWithFiveDays
//
//  Created by Je Min Son on 12/12/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchBarViewController: UIViewController {

    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var cityTableView: UITableView!
    
    let cityViewModel = CityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search Cities"
        
        getAllCityList()
    }

}

// MARK: - Functions
extension SearchBarViewController {
    func getAllCityList() {
        SVProgressHUD.show(withStatus: "Loading Cities...")
        cityViewModel.getAllCityInfo { (cityModel) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.cityTableView.reloadData()
            }
        }
    }
}

// MARK: - TableView DataSource
extension SearchBarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityViewModel.getAllCityRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBarTableViewCell") as! SearchBarTableViewCell
        
        let cities = cityViewModel.getAllCityIndex(atIndex: indexPath.row)
        cell.cityLabel.text = cities.cityName!
        cell.countryLabel.text = cities.country!
        
        return cell
    }
}

// MARK: - Search Delegate
extension SearchBarViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        citySearchBar.text = searchText.uppercased()
        SVProgressHUD.show(withStatus: "Loading Cities...")
        cityViewModel.getCitySortedByCityName(searchBarText: citySearchBar.text!)
        
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            self.cityTableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cityViewModel.getCitySortedByCityNameCancel()
        citySearchBar.text = ""
        citySearchBar.resignFirstResponder()
        DispatchQueue.main.async {
            self.cityTableView.reloadData()
        }
    }
    
    
    
}
