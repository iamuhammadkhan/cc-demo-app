//
//  RestaurantsVC.swift
//  cc-demoApp
//
//  Created by Muhammad Khan on 13/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import UIKit

class RestaurantsVC: UIViewController {

    @IBOutlet weak var restaurantsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantsTableView.delegate = self
        restaurantsTableView.dataSource = self
    }

    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension RestaurantsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = restaurantsTableView.dequeueReusableCell(withIdentifier: "RestaurantsCell", for: indexPath) as! RestaurantsCell
        return cell
    }
}
