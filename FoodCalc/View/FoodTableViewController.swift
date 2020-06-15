//
//  FoodTableViewController.swift
//  FoodCalc
//
//  Created by Muhammad Raihan on 23/05/20.
//  Copyright © 2020 Muhammad Raihan M. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        Food.foodList(withFoodName: "Steak") { (results:[Food]) in
            for result in results {
                print("\(result)\n\n")
                print("TEST")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }

}

extension FoodTableViewController: UISearchBarDelegate{
    
}
