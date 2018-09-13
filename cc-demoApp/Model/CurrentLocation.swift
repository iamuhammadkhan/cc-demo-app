//
//  CurrentLocation.swift
//  ccdemoapp
//
//  Created by Muhammad Khan on 09/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import Foundation

final class CurrentLocation {
    
    // MARK:- Private Variable
    
    private var _lat: Double
    private var _lng: Double
    
    
    // MARK:- Getter Setter for Current Class
    
    var lat: Double {
        get {
            return _lat
        }
        set {
            _lat = newValue
        }
    }
    
    var lng: Double {
        get {
            return _lng
        }
        set {
            _lng = newValue
        }
    }
    
    
    // MARK:- Initializer for current class
    
    init(_ lat: Double, _ lng: Double) {
        self._lat = lat
        self._lng = lng
    }
}

