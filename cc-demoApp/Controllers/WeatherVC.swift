//
//  WeatherVC.swift
//  cc-demoApp
//
//  Created by Muhammad Khan on 13/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, CLLocationManagerDelegate {

    // MARK:- Variables / Constants
    
    private let restaurantsVCSegue = "showRestaurantsVC"
    private var locationManager: CLLocationManager!
    private var currentLocation: CurrentLocation!
    
    private let showRestaurantsBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.8038449883, green: 0.6284809709, blue: 0.4078141749, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 12)
        button.setTitle("NEARBY RESTUARANTS", for: .normal)
        button.addTarget(self, action: #selector(showNearbyResturants), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK:- Viewcontroller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    
    // MARK:- View Setup Functions

    private func setupViews() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationService()
        
        view.addSubview(showRestaurantsBtn)
        showRestaurantsBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        showRestaurantsBtn.widthAnchor.constraint(equalToConstant: 180).isActive = true
        showRestaurantsBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        showRestaurantsBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    
    // MARK:- User Location Functions

    func locationService() {
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch(CLLocationManager.authorizationStatus()) {
                
            case .notDetermined, .restricted, .denied:
                
                print("Location Service Denied")
                AlertService.shared.locationAlert(in: self)
                
            case .authorizedAlways, .authorizedWhenInUse:
                
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startMonitoringSignificantLocationChanges()
                locationManager.startUpdatingLocation()
            }
        } else {
            AlertService.shared.locationAlert(in: self)
            locationService()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            
            print("Lat : ", lat)
            print("Lng : ", lng)
            
            currentLocation = CurrentLocation(lat, lng)
            
            locationManager.stopUpdatingLocation()
            
            print("Current Location : ", currentLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            AlertService.shared.locationAlert(in: self)
            locationService()
        }
    }
    
    
    // MARK:- UI Element Actions
    
    @objc private func showNearbyResturants() {
        performSegue(withIdentifier: restaurantsVCSegue, sender: nil)
    }
}

