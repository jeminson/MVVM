//
//  SearchBarViewController.swift
//  MVVM_WeatherWithFiveDays
//
//  Created by Je Min Son on 12/12/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol CityDelegate {
    func cityValue(cityInfo: CityModel)
}

class SearchBarViewController: UIViewController {

    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var cityTableView: UITableView!
    
    let cityViewModel = CityViewModel()
    var delegate: CityDelegate?
    
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
        cell.addBtn.tag = indexPath.row
        cell.addBtn.addTarget(self, action: #selector(addCity), for: .touchUpInside)
        
        return cell
    }
    
    @objc func addCity(_ sender: UIButton) {
        let cities = cityViewModel.getAllCityIndex(atIndex: sender.tag)
        
        let AlertController = UIAlertController(title: "Add", message: "Click OK to add to your list", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.delegate?.cityValue(cityInfo: cities)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("cancel")
        }
        
        AlertController.addAction(okAction)
        AlertController.addAction(cancelAction)
        
        present(AlertController, animated: true, completion: nil)
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
