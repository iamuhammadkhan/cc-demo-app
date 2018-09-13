//
//  RestaurantsCell.swift
//  cc-demoApp
//
//  Created by Muhammad Khan on 13/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import UIKit

class RestaurantsCell: UITableViewCell {

    @IBOutlet private weak var restaurantName: UILabel!
    @IBOutlet private weak var restaurantImage: UIImageView!
    @IBOutlet private weak var restaurantLocation: UILabel!
    @IBOutlet private weak var restaurantType: UILabel!
    @IBOutlet private weak var restaurantReviews: UILabel!
    @IBOutlet private weak var restaurantRating: UILabel!
    @IBOutlet private weak var ratingStar1: UIImageView!
    @IBOutlet private weak var ratingStar2: UIImageView!
    @IBOutlet private weak var ratingStar3: UIImageView!
    @IBOutlet private weak var ratingStar4: UIImageView!
    @IBOutlet private weak var ratingStar5: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        restaurantName.text?.removeAll()
        restaurantType.text?.removeAll()
        restaurantRating.text?.removeAll()
        restaurantLocation.text?.removeAll()
        restaurantReviews.text?.removeAll()
        
        restaurantImage.image = #imageLiteral(resourceName: "image")
        ratingStar1.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        ratingStar2.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        ratingStar3.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        ratingStar4.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        ratingStar5.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    func populate() {
        
    }
}

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
}
