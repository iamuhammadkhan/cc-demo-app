//
//  WeatherAPIService.swift
//  cc-demoApp
//
//  Created by Muhammad Khan on 21/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct WeatherAPIService {
    
    private init () {}
    
    static let shared = WeatherAPIService()
    
    func getWeatherData(_ city: String, completion: @escaping (Weather?, Error?) -> Void) {
        
        let url = WeatherAPIConstants.shared.getForcastWeatherUrl(city, "7")
        
        print("URL : ", url)
        
        Alamofire.request(url).response { (response) in
            if let error = response.error {
                completion(nil, error)
            } else {
                do {
                    
                    let json = try JSON(data: response.data!)

                    print("JSON - Weather Response : ", json)
                    
                    let location = json["location"]
                    let current = json["current"]
                    let forecast = json["forecast"]
                    
                    let name = location["name"].stringValue
                    let country = location["country"].stringValue
                    let lat = location["lat"].doubleValue
                    let localTime = location["localtime"].stringValue
                    let lng = location["lon"].doubleValue
                    let region = location["region"].stringValue
                    
                    let currentLocation = Location(country: country, lat: lat, localtime: localTime, lng: lng, name: name, region: region)
                    
                    let humidity = current["humidity"].intValue
                    let temp_c = current["temp_c"].intValue
                    let precip_in = current["precip_in"].intValue
                    let wind_kph = current["wind_kph"].floatValue
                    let condition = current["condition"]
                    
                    let text = condition["text"].stringValue
                    let icon = condition["icon"].stringValue
                    
                    let currentCondition = Condition(icon: icon, text: text)
                    
                    let today = Current(condition: currentCondition, humidity: humidity, precipIn: precip_in, tempC: temp_c, windKph: wind_kph)
                                        
                    var forecastDays = [Forecastday]()
                    
                    let forecastday = forecast["forecastday"].arrayValue
                    
                    for item in forecastday {
                        
                        let date = item["date"].stringValue
                        let day = item["day"]
                        
                        let mintemp_c = day["mintemp_c"].floatValue
                        let maxtemp_c = day["maxtemp_c"].floatValue
                        
                        let forecastCondition = day["condition"]
                        
                        let text = forecastCondition["text"].stringValue
                        let icon = forecastCondition["icon"].stringValue
                        
                        let forecastedCondition = Condition(icon: icon, text: text)
                        
                        let forecastDay = Day(condition: forecastedCondition, maxtempC: mintemp_c, mintempC: maxtemp_c)
                        
                        let forcastedDay = Forecastday(date: date, day: forecastDay)
                        
                        forecastDays.append(forcastedDay)
                    }
                    
                    let currentForecast = Forecast(forecastday: forecastDays)
                    
                    let weather = Weather(current: today, forecast: currentForecast, location: currentLocation)
                    
                    completion(weather, nil)
                    
                } catch {
                    completion(nil, error)
                }
            }
        }
    }
}
