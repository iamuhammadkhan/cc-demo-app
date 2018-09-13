//
//  AlertService.swift
//  ccdemoapp
//
//  Created by Muhammad Khan on 09/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import UIKit

struct AlertService {
    
    private init () {}
    
    static let shared = AlertService()
    
    func locationAlert(in vc: UIViewController) {
        let alert = UIAlertController(title: nil, message: "We would like to access your current location in order to deliver with best possible services", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        vc.present(alert, animated: true, completion: nil)
    }
}
