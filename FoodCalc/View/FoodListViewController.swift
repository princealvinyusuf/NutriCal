//
//  FoodListViewController.swift
//  FoodCalc
//
//  Created by Muhammad Raihan on 24/05/20.
//  Copyright © 2020 Muhammad Raihan M. All rights reserved.
//

import UIKit
import CoreData

class FoodListViewController: UIViewController {

    var foods = [FoodCD]()
    var managedObjectContext: NSManagedObjectContext?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var totalKal:Float = 0
    
    var isBreakfast: Bool = false
    var isDinner: Bool = false
    var isLunch: Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var caloriesTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var foodTypes: UILabel!
    @IBOutlet weak var totakKal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = appDelegate?.persistentContainer.viewContext
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
        foodIdentifier()
        
    }
    
    
    @IBAction func addButtonTouched(_ sender: Any) {
        addData()
    }
    func foodIdentifier(){
        if isBreakfast{
            foodTypes.text = "Breakfast"
        }
        else if isLunch{
            foodTypes.text = "Lunch"
        }
        else{
            foodTypes.text = "Dinner"
        }
    }
    
    func addData(){
        let entity = NSEntityDescription.entity(forEntityName: "FoodCD", in: managedObjectContext!)
        let newFood = NSManagedObject(entity: entity!, insertInto: managedObjectContext!)
        
        if let name = nameTextField.text{
            newFood.setValue(name, forKey: "name")
        }
        
        if let calories = Float(caloriesTextField.text!){
            newFood.setValue(calories, forKey: "calories")
        }
        
        do {
            try managedObjectContext?.save()
            print("saved \(newFood)")
        }catch let error as NSError{
            print("Couldnot save \(error)")
        }
        loadData()
    }
    
    func loadData(){
        let foodRequest: NSFetchRequest<FoodCD> = FoodCD.fetchRequest()
        do {
            try foods = managedObjectContext!.fetch(foodRequest)
        }catch {
            print("COuld not load data")
        }
        var totalkalori = totalKal.self
        //For Calculate total cal
        for foods in foods {
            //print(foods.calories)
            totalkalori = totalkalori + foods.calories!.floatValue
            print(totalkalori)
            
        }
        totakKal.text = String(totalkalori)
        tableView.reloadData()
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
        loadData()
    }
    

}
extension FoodListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let foodData = foods[indexPath.row]
        
        if foods.count > 0 {
            cell.textLabel?.text = "\(foodData.name!) dengan kalori \(foodData.calories!)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            let toBeDelete = foods[indexPath.row]
            deleteData(name: toBeDelete.name!)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
}
