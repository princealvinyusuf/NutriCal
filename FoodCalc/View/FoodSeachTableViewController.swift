//
//  FoodSeachTableViewController.swift
//  FoodCalc
//
//  Created by Muhammad Raihan on 27/05/20.
//  Copyright © 2020 Muhammad Raihan M. All rights reserved.
// test

import UIKit
import CoreData

class FoodSeachTableViewController: UITableViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var foods = [FoodCD]()
    var managedObjectContext: NSManagedObjectContext?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var totalKal:Float = 0
    var foodType:String = ""
    
    var isChoose: Bool = false
    var indexChoose: Int = 0
    
    
    var FoodList = [FoodData]()
    var datatest = ["Raihan", "Jihan"]
    override func viewDidLoad() {
        super.viewDidLoad()
        //Localization
        self.navigationItem.title = NSLocalizedString("foodadd_title", comment: "")
        saveButton.setTitle(NSLocalizedString("foodadd_savebutton", comment: ""), for: .normal)
        
        searchBar.delegate = self
        managedObjectContext = appDelegate?.persistentContainer.viewContext
        
    }

    // MARK: - Table view data source

    @IBAction func saveButtonPressed(_ sender: Any) {
        if isChoose{
            print("clicked")
            addData(index: indexChoose)
        }else{
            print ("not clicked")
            print (indexChoose)
        }
    }
    
    func deleteData(name:String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodCD")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
       

        
        do{
            let objects = try managedObjectContext!.fetch(fetchRequest)
            let objectsToDelete = objects[0] as! NSManagedObject
            managedObjectContext?.delete(objectsToDelete)
            
            do {
                try managedObjectContext!.save()
            }catch{
                print ("Error Saving After Deletion  \(error)")
            }
        }catch{
            print("Error Fetching for deletion: \(error)")
        }
        //loadData(name: foodType)
    }
    
    func addData(index: Int){
        let entity = NSEntityDescription.entity(forEntityName: "FoodCD", in: managedObjectContext!)
        let newFood = NSManagedObject(entity: entity!, insertInto: managedObjectContext!)
        let food = FoodList[index]
        
        let date = NSDate()
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var dateString = dateFormatter.string(from: date as Date)
        
        newFood.setValue(food.fields.item_name, forKey: "name")
        newFood.setValue(food.fields.nf_calories, forKey: "calories")
        newFood.setValue(food.fields.nf_total_fat, forKey: "fats")
        newFood.setValue(food.fields.nf_total_carbohydrate, forKey: "carbs")
        newFood.setValue(food.fields.nf_protein, forKey: "protein")
        newFood.setValue(foodType, forKey: "type")
        newFood.setValue(dateString, forKey: "date")
        
        do {
            try managedObjectContext?.save()
            print("saved \(newFood)")
        }catch let error as NSError{
            print("Couldnot save \(error)")
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FoodList.count
    }

    override func tableView(  _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let food = FoodList[indexPath.row]
        cell.textLabel?.text = food.fields.item_name
        cell.detailTextLabel?.text = food.fields.nf_calories?.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isChoose = true
        let index: Int = indexPath.row
        indexChoose.self = index
        
    }
    

}

extension FoodSeachTableViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar){
        guard let searchBarText = searchBar.text?.replacingOccurrences(of: " ", with: "_") else {return}
        let anonymousFunction = {(fetchedFoodList: [FoodData]) in
            DispatchQueue.main.async {
                self.FoodList = fetchedFoodList
                self.tableView.reloadData()
            }
            
        }
        let foodRequest = FoodAPI.self
        foodRequest.shared.fetchFoodList(name: searchBarText, onCompletion: anonymousFunction)    }
}
