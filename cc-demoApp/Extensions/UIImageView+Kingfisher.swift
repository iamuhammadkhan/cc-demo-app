//
//  UIImageView+Kingfisher.swift
//  cc-demoApp
//
//  Created by Muhammad Khan on 21/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setSmallWeatherImageWithUrl(url: String) {
        
        if let newUrl = URL(string: "https:" + url) {
            kf.indicatorType = .activity
            kf.setImage(with: newUrl)
        }
    }
    
    func setMediumWeatherImageWithUrl(url: String) {
        
        let newUrl = url.replacingOccurrences(of: "64", with: "128")
        
        let urlStr = "https:" + newUrl
        
        if let absoluteUrl = URL(string: urlStr) {
            kf.indicatorType = .activity
            kf.setImage(with: absoluteUrl)
        }
    }
}
