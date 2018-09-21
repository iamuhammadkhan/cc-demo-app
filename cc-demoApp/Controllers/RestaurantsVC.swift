//
//  RestaurantsVC.swift
//  cc-demoApp
//
//  Created by Muhammad Khan on 13/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import UIKit

class RestaurantsVC: UIViewController {

    // MARK:- IBOutlets
    
    @IBOutlet weak var restaurantsTableView: UITableView!
    
    
    // MARK:- Viewcontroller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantsTableView.delegate = self
        restaurantsTableView.dataSource = self
    }
    
    
    // MARK:- IBActions

    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension RestaurantsVC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK:- Tableview Datasource Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = restaurantsTableView.dequeueReusableCell(withIdentifier: RestaurantsCell.identifier, for: indexPath) as? RestaurantsCell else { return UITableViewCell() }
        
        return cell
    }
    
    
    // MARK:- Tableview Delegate Functions
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140 // It will return a static height, you can play with like view.bounds.size.height / 5 or 6 or 7 depending upon UI need //
    }
}
