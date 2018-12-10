//
//  CoreLocationViewModel.swift
//  MVVM_CoreLocation
//
//  Created by Je Min Son on 12/10/18.
//  Copyright © 2018 Jason Son. All rights reserved.
//

import Foundation
import CoreLocation

class CoreLocationViewModel: NSObject {
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
    }
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?) -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        } else {
            // No location was available.
            completionHandler(nil)
        }
    }
}

// MARK: - Location Manager Delegate
extension CoreLocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("Not Determined")
        case .authorizedWhenInUse:
            print("Authorized when in use")
        case .authorizedAlways:
            print("Authorized always")
        case .restricted:
            print("Restriced")
        case .denied:
            print("Denied")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            print("\(lat), \(long)")
        } else {
            print("No coordinates")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
