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
    private lazy var geocoder: CLGeocoder = {
        let gc = CLGeocoder()
        return gc
    }()
    
    private let showRestaurantsBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17
        button.clipsToBounds = true
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.8038449883, green: 0.6284809709, blue: 0.4078141749, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 12)
        button.setTitle("NEARBY RESTUARANTS", for: .normal)
        button.addTarget(self, action: #selector(showNearbyResturants), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Karachi"
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Bold", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunday"
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Clear with periodic clouds"
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .equalCentering
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let tempratureStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        sv.spacing = 0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let tempratureLabel: UILabel = {
        let label = UILabel()
        label.text = "37"
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 80)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempratureIndicatorLabel: UILabel = {
        let label = UILabel()
        label.text = "°C"
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "partialy-cloudy")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bottomMainStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let day1StackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let day1DateLbl: UILabel = {
        let label = UILabel()
        label.text = "MON"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let day1WeatherImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "sunny")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let day1TempratureLbl: UILabel = {
        let label = UILabel()
        label.text = "37 / 26"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let day2StackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let day2DateLbl: UILabel = {
        let label = UILabel()
        label.text = "TUE"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let day2WeatherImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "sunny")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let day2TempratureLbl: UILabel = {
        let label = UILabel()
        label.text = "37 / 26"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let day3StackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let day3DateLbl: UILabel = {
        let label = UILabel()
        label.text = "WED"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let day3WeatherImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "sunny")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let day3TempratureLbl: UILabel = {
        let label = UILabel()
        label.text = "37 / 26"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let day4StackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let day4DateLbl: UILabel = {
        let label = UILabel()
        label.text = "THU"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let day4WeatherImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "sunny")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let day4TempratureLbl: UILabel = {
        let label = UILabel()
        label.text = "37 / 26"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let day5StackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let day5DateLbl: UILabel = {
        let label = UILabel()
        label.text = "FRI"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let day5WeatherImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "sunny")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let day5TempratureLbl: UILabel = {
        let label = UILabel()
        label.text = "37 / 26"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let day6StackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let day6DateLbl: UILabel = {
        let label = UILabel()
        label.text = "SAT"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let day6WeatherImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "sunny")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let day6TempratureLbl: UILabel = {
        let label = UILabel()
        label.text = "37 / 26"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let day7StackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let day7DateLbl: UILabel = {
        let label = UILabel()
        label.text = "SUN"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let day7WeatherImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "sunny")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let day7TempratureLbl: UILabel = {
        let label = UILabel()
        label.text = "37 / 26"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let middleStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let precipitationStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .center
        sv.spacing = 2
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let precipitationValueLbl: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let precipitationIndicatorLbl: UILabel = {
        let label = UILabel()
        label.text = "%"
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let precipitationInnerStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let precipitationLbl: UILabel = {
        let label = UILabel()
        label.text = "Precipitation"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let humidityStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .center
        sv.spacing = 2
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let humidityValueLbl: UILabel = {
        let label = UILabel()
        label.text = "65"
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let humidityIndicatorLbl: UILabel = {
        let label = UILabel()
        label.text = "%"
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let humidityInnerStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let humidityLbl: UILabel = {
        let label = UILabel()
        label.text = "Humidity"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let windStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .center
        sv.spacing = 2
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let windValueLbl: UILabel = {
        let label = UILabel()
        label.text = "12"
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let windIndicatorLbl: UILabel = {
        let label = UILabel()
        label.text = "Km/h"
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let windInnerStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let windLbl: UILabel = {
        let label = UILabel()
        label.text = "Wind"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let topMargin = statusBarHeight + 50
        
        view.addSubview(showRestaurantsBtn)
        showRestaurantsBtn.heightAnchor.constraint(equalToConstant: 34).isActive = true
        showRestaurantsBtn.widthAnchor.constraint(equalToConstant: 180).isActive = true
        showRestaurantsBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: topMargin).isActive = true
        showRestaurantsBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(cityLabel)
        cityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topMargin).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: showRestaurantsBtn.leadingAnchor, constant: -5).isActive = true
        
        view.addSubview(dayLabel)
        dayLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 2).isActive = true
        dayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        dayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(weatherMessageLabel)
        weatherMessageLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 0).isActive = true
        weatherMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        weatherMessageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(weatherStackView)
        weatherStackView.topAnchor.constraint(equalTo: weatherMessageLabel.bottomAnchor, constant: 30).isActive = true
        weatherStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        weatherStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        weatherImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        weatherImage.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        tempratureStackView.addArrangedSubview(tempratureLabel)
        tempratureStackView.addArrangedSubview(tempratureIndicatorLabel)
        
        weatherStackView.addArrangedSubview(weatherImage)
        weatherStackView.addArrangedSubview(tempratureStackView)
        
        view.addSubview(bottomView)
        bottomView.heightAnchor.constraint(equalToConstant: view.bounds.size.height / 4).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        bottomView.addSubview(bottomMainStack)
        bottomMainStack.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20).isActive = true
        bottomMainStack.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20).isActive = true
        bottomMainStack.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20).isActive = true
        bottomMainStack.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -30).isActive = true
        
        day1WeatherImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        day1WeatherImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        day2WeatherImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        day2WeatherImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        day3WeatherImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        day3WeatherImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        day4WeatherImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        day4WeatherImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        day5WeatherImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        day5WeatherImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        day6WeatherImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        day6WeatherImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        day7WeatherImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        day7WeatherImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        day1StackView.addArrangedSubview(day1DateLbl)
        day1StackView.addArrangedSubview(day1WeatherImage)
        day1StackView.addArrangedSubview(day1TempratureLbl)
        
        day2StackView.addArrangedSubview(day2DateLbl)
        day2StackView.addArrangedSubview(day2WeatherImage)
        day2StackView.addArrangedSubview(day2TempratureLbl)
        
        day3StackView.addArrangedSubview(day3DateLbl)
        day3StackView.addArrangedSubview(day3WeatherImage)
        day3StackView.addArrangedSubview(day3TempratureLbl)
        
        day4StackView.addArrangedSubview(day4DateLbl)
        day4StackView.addArrangedSubview(day4WeatherImage)
        day4StackView.addArrangedSubview(day4TempratureLbl)
        
        day5StackView.addArrangedSubview(day5DateLbl)
        day5StackView.addArrangedSubview(day5WeatherImage)
        day5StackView.addArrangedSubview(day5TempratureLbl)
        
        day6StackView.addArrangedSubview(day6DateLbl)
        day6StackView.addArrangedSubview(day6WeatherImage)
        day6StackView.addArrangedSubview(day6TempratureLbl)
        
        day7StackView.addArrangedSubview(day7DateLbl)
        day7StackView.addArrangedSubview(day7WeatherImage)
        day7StackView.addArrangedSubview(day7TempratureLbl)
        
        bottomMainStack.addArrangedSubview(day1StackView)
        bottomMainStack.addArrangedSubview(day2StackView)
        bottomMainStack.addArrangedSubview(day3StackView)
        bottomMainStack.addArrangedSubview(day4StackView)
        bottomMainStack.addArrangedSubview(day5StackView)
        bottomMainStack.addArrangedSubview(day6StackView)
        bottomMainStack.addArrangedSubview(day7StackView)
        
        view.addSubview(middleStackView)
        middleStackView.topAnchor.constraint(equalTo: weatherStackView.bottomAnchor, constant: 30).isActive = false
        middleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        middleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        middleStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomView.topAnchor, constant: -90).isActive = true
        
        precipitationInnerStackView.addArrangedSubview(precipitationValueLbl)
        precipitationInnerStackView.addArrangedSubview(precipitationIndicatorLbl)
        
        precipitationStackView.addArrangedSubview(precipitationInnerStackView)
        precipitationStackView.addArrangedSubview(precipitationLbl)
        
        humidityInnerStackView.addArrangedSubview(humidityValueLbl)
        humidityInnerStackView.addArrangedSubview(humidityIndicatorLbl)
        
        humidityStackView.addArrangedSubview(humidityInnerStackView)
        humidityStackView.addArrangedSubview(humidityLbl)
        
        windInnerStackView.addArrangedSubview(windValueLbl)
        windInnerStackView.addArrangedSubview(windIndicatorLbl)
        
        windStackView.addArrangedSubview(windInnerStackView)
        windStackView.addArrangedSubview(windLbl)
        
        middleStackView.addArrangedSubview(precipitationStackView)
        middleStackView.addArrangedSubview(humidityStackView)
        middleStackView.addArrangedSubview(windStackView)
    }
    
    
    // MARK:- Current Location Functions

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
        
        if let location = locations.last {
            
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            
            geocoder.reverseGeocodeLocation(location) { [weak self] (placemark, error) in
                if let err = error {
                    print("Error : ", err)
                } else {
                    if let place = placemark?.last {
                        if let city = place.locality {
                            self?.currentLocation = CurrentLocation(lat, lng, city)
                            self?.locationManager.stopUpdatingLocation()
                        }
                    }
                }
            }
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

