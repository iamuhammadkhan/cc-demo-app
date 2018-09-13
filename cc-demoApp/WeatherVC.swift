//
//  WeatherVC.swift
//  cc-demoApp
//
//  Created by Muhammad Khan on 13/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {

    private let restaurantsVCSegue = "showRestaurantsVC"
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    private func setupViews() {
        
        view.addSubview(showRestaurantsBtn)
        showRestaurantsBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        showRestaurantsBtn.widthAnchor.constraint(equalToConstant: 180).isActive = true
        showRestaurantsBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        showRestaurantsBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }

    @objc private func showNearbyResturants() {
        performSegue(withIdentifier: restaurantsVCSegue, sender: nil)
    }
}

