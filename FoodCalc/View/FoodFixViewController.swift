//
//  FoodListFixViewController.swift
//  FoodCalc
//
//  Created by Muhammad Raihan on 27/05/20.
//  Copyright © 2020 Muhammad Raihan M. All rights reserved.
//

import UIKit
import CoreData

class FoodListViewController: UIViewController, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var foodListLabel: UILabel!
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBOutlet var illustrationImage: UIImageView!
    @IBOutlet weak var subTitle: UILabel!
    
    
    
    var foods = [FoodCD]()
    var managedObjectContext: NSManagedObjectContext?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var totalKal:Float = 0
    
    var isBreakfast: Bool = false
    var isDinner: Bool = false
    var isLunch: Bool = false
    var foodType:String = ""
    var foodDate:String = ""
    
    
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var foodTypes: UILabel!
    override func viewDidLoad() {
        
        //localization
        subTitle.text = NSLocalizedString("foodlist_subtitle", comment: "")
        
        
        super.viewDidLoad()
        checkDate(dateCheck: foodDate)
        foodIdentifier()
        print(foodType)
        managedObjectContext = appDelegate?.persistentContainer.viewContext
        tableView.dataSource = self
        tableView.delegate = self
        loadData(name: foodType, date: foodDate)
        print(foods)
        applyAccessibility()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        loadData(name: foodType, date: foodDate)
    }
    @IBAction func unwindToFoodView(_ sender: UIStoryboardSegue){}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addFoodSegue"{
            let addVC = segue.destination as! FoodSeachTableViewController
            addVC.foodType = foodType
        }
        if segue.identifier == "foodListSegueBreakfast"{
            let homeVC = segue.destination as! FoodStatViewController
            //            homeVC.loadData()
        }
    }
    
    func foodIdentifier(){
        if isBreakfast{
            //foodTypes.text = "Breakfast"
            foodImageView.image = UIImage(named: "Breakfast Illustration")
            foodType = "Breakfast"
            illustrationImage.accessibilityTraits = .image
            illustrationImage.accessibilityLabel = "illustration of breakfast"
            self.navigationItem.title = NSLocalizedString("foodlist_title1", comment: "")
        }
        else if isLunch{
            //foodTypes.text = "Lunch"
            foodImageView.image = UIImage(named: "Lunch Illustration")
            foodType = "Lunch"
            illustrationImage.accessibilityTraits = .image
            illustrationImage.accessibilityLabel = "illustration of lunch"
            self.navigationItem.title = NSLocalizedString("foodlist_title2", comment: "")
            
            
        }
        else{
            //foodTypes.text = "Dinner"
            foodImageView.image = UIImage(named: "Dinner Illustration")
            foodType = "Dinner"
            illustrationImage.accessibilityTraits = .image
            illustrationImage.accessibilityLabel = "illustration of dinner"
            self.navigationItem.title = NSLocalizedString("foodlist_title3", comment: "")
            
        }
    }
    func loadData(name:String, date:String){
        let foodRequest: NSFetchRequest<FoodCD> = FoodCD.fetchRequest()
        let predicate1 = NSPredicate(format: "type = %@", name)
        let predicate2 = NSPredicate(format: "date = %@", date)
        foodRequest.predicate = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1, predicate2])
        do {
            try foods = managedObjectContext!.fetch(foodRequest)
        }catch {
            print("COuld not load data")
        }
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
        loadData(name: foodType, date: foodDate)
    }
    
    func checkDate(dateCheck: String){
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date as Date)
        if dateString == dateCheck {
            return
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
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
            cell.textLabel?.text = "\(foodData.name!) with \(foodData.calories!) g of calories"
        }
        //print (foodData.date ?? nil)
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
    
    func applyAccessibility() {
        foodListLabel.font = .preferredFont(forTextStyle: .title2)
        foodListLabel.adjustsFontForContentSizeCategory = true
    }
    
    
}
