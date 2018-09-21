//
//  WeatherAPIConstants.swift
//  cc-demoApp
//
//  Created by Muhammad Khan on 21/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import Foundation

struct WeatherAPIConstants {
    
    private init () {}
    
    static let shared = WeatherAPIConstants()
    
    private let scheme = "https://" //https://api.apixu.com/v1/forecast.json?key=5dcab4f136034e1eb1495617181809&q=Karachi
    
    private let host = "api.apixu.com/"
    
    private let path = "v1/"
    
    private let currentWeather = "current.json"
    
    private let forcastWeather = "forecast.json"
    
    private let apiKey = "5dcab4f136034e1eb1495617181809"
    
    private func getBaseUrl() -> String {
        return "\(scheme)\(host)\(path)"
    }
    
    func getCurrentWeatherUrl(_ city: String) -> String {
        let baseUrl = getBaseUrl()
        return "\(baseUrl)\(currentWeather)?key=\(apiKey)&q=\(city)"
    }
    
    func getForcastWeatherUrl(_ city: String, _ days: String) -> String {
        let baseUrl = getBaseUrl()
        return "\(baseUrl)\(forcastWeather)?key=\(apiKey)&q=\(city)&days=\(days)"
    }
}
