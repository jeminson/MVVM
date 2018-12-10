//
//  ViewController.swift
//  MVVM_CoreLocation
//
//  Created by Je Min Son on 12/10/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var currentLocationLabel: UILabel!
    let coreLocationViewModel = CoreLocationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        coreLocationViewModel.lookUpCurrentLocation { placeMark in
            
            DispatchQueue.main.async {
                self.currentLocationLabel.text = "Current Location: \((placeMark?.locality)!)"
            }
        }
    }
}

