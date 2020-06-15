//
//  TableViewController.swift
//  FoodCalc
//
//  Created by Muhammad Raihan on 22/05/20.
//  Copyright © 2020 Muhammad Raihan M. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var FoodList = [Food]()

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        let anonymousFunction = { (fetchedFoodList: [Food]) in
            self.FoodList = fetchedFoodList
            self.tableView.reloadData()
            
        }
        FoodAPI.shared.fetchFoodList(foodName: "rendang", onCompletion: anonymousFunction)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    override func tableView(  _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let name = FoodList[indexPath.row]
        cell.textLabel?.text = FoodList.
    }

}

extension TableViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar){
    }
}


