//
//  UITabelViewCell+Identifier.swift
//  cc-demoApp
//
//  Created by Muhammad Khan on 21/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
}
