//
//  FoodStatViewController.swift
//  FoodCalc
//
//  Created by Muhammad Raihan on 27/05/20.
//  Copyright © 2020 Muhammad Raihan M. All rights reserved.
//

import UIKit
import CoreData

class FoodStatViewController: UITableViewController, CanReceieve, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var fats: UILabel!
    @IBOutlet weak var proteins: UILabel!
    @IBOutlet weak var carbs: UILabel!
    @IBOutlet weak var foodDiaryLabel: UILabel!
    
    
    
    func passDataBack(data: String) {
        dateButton.setTitle(data, for: .normal)
        foodDate = data
        loadData(date: foodDate)
    }
    
    // CORE DATA DECLARATION
    var foods = [FoodCD]()
    var managedObjectContext: NSManagedObjectContext?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var totalCal: Float = 0
    var totalFats: Float = 0
    var totalProt: Float = 0
    var totalCarbs: Float = 0
    var foodDate : String = ""
    
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var fatsLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var breakfastButton: UIButton!
    @IBOutlet weak var lunchButton: UIButton!
    @IBOutlet weak var dinnerButton: UIButton!
    
    @IBOutlet weak var dateButton: UIButton!
    private var datePicker: UIDatePicker?
    override func viewDidLoad() {
        super.viewDidLoad()
        //LOCALIZATION
        
        self.navigationItem.title = NSLocalizedString("foodstat_title", comment: "")
        calories.text = NSLocalizedString("foodstat_calories", comment: "")
        fats.text = NSLocalizedString("foodstat_fats", comment: "")
        proteins.text = NSLocalizedString("foodstat_proteins", comment: "")
        carbs.text = NSLocalizedString("foodstat_carbs", comment: "")
        foodDiaryLabel.text = NSLocalizedString("foodstat_fooddiary", comment: "")
        breakfastButton.setTitle(NSLocalizedString("foodstat_mybreakfast", comment: ""), for: .normal)
        lunchButton.setTitle(NSLocalizedString("foodstat_mylunch", comment: ""), for: .normal)
        dinnerButton.setTitle(NSLocalizedString("foodstat_mydinner", comment: ""), for: .normal)

        
        
        
        
        managedObjectContext = appDelegate?.persistentContainer.viewContext
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        let currentDate = format.string(from: date)
        dateButton.setTitle(currentDate, for: .normal)
        foodDate = currentDate
        loadData(date: foodDate)
        print(foods)
        applyAccessibility()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        loadData(date: foodDate)
        print(foodDate)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseDate"{
            let chooseDateVC = segue.destination as! DatePopUpViewController
            chooseDateVC.delegate = self
            chooseDateVC.date = foodDate
        }
        if segue.identifier == "foodListSegueBreakfast"{
            let chooceVC = segue.destination as! FoodListViewController
            chooceVC.isBreakfast = true
            chooceVC.isDinner = false
            chooceVC.isLunch = false
            chooceVC.foodDate = foodDate
        }
        if segue.identifier == "foodListSegueDinner"{
            let chooceVC = segue.destination as! FoodListViewController
            chooceVC.isBreakfast = false
            chooceVC.isDinner = true
            chooceVC.isLunch = false
            chooceVC.foodDate = foodDate
            
        }
        if segue.identifier == "foodListSegueLunch"{
            let chooceVC = segue.destination as! FoodListViewController
            chooceVC.isBreakfast = false
            chooceVC.isDinner = false
            chooceVC.isLunch = true
            chooceVC.foodDate = foodDate
            
        }
    }
    
    func loadData(date:String){
        print("Data Loaded")
        let foodRequest: NSFetchRequest<FoodCD> = FoodCD.fetchRequest()
        foodRequest.predicate = NSPredicate(format: "date = %@", date)
        do {
            try foods = managedObjectContext!.fetch(foodRequest)
        }catch {
            print("COuld not load data")
        }
        totalCal = 0
        totalCarbs = 0
        totalProt = 0
        totalFats = 0
        if foods.count > 0{
            for i in 0...foods.count-1{
                let foodDatas = foods[i]
                
                totalCal += foodDatas.calories!.floatValue
                totalFats += foodDatas.fats!.floatValue
                totalProt += foodDatas.protein!.floatValue
                totalCarbs += foodDatas.carbs!.floatValue
            }
        }
        
        caloriesLabel.text = ("\(String (totalCal)) g")
        fatsLabel.text = ("\(String (totalFats)) g")
        proteinLabel.text = ("\(String (totalProt)) g")
        carbsLabel.text = ("\(String (totalCarbs)) g")
    }
    
    @IBAction func dateButtonClicked(_ sender: Any) {
        dateButton.accessibilityLabel = "Date"
        dateButton.accessibilityTraits = .button
        
    }
    
}

extension FoodStatViewController {
    func applyAccessibility() {
        calories.font = .preferredFont(forTextStyle: .title1)
        calories.adjustsFontForContentSizeCategory = true
        fats.font = .preferredFont(forTextStyle: .title1)
        fats.adjustsFontForContentSizeCategory = true
        proteins.font = .preferredFont(forTextStyle: .title1)
        proteins.adjustsFontForContentSizeCategory = true
        carbs.font = .preferredFont(forTextStyle: .title1)
        carbs.adjustsFontForContentSizeCategory = true
        
        caloriesLabel.font = .preferredFont(forTextStyle: .title1)
        caloriesLabel.adjustsFontForContentSizeCategory = true
        fatsLabel.font = .preferredFont(forTextStyle: .title1)
        fatsLabel.adjustsFontForContentSizeCategory = true
        proteinLabel.font = .preferredFont(forTextStyle: .title1)
        proteinLabel.adjustsFontForContentSizeCategory = true
        carbsLabel.font = .preferredFont(forTextStyle: .title1)
        carbsLabel.adjustsFontForContentSizeCategory = true
        
        //        aboutNutrical.isAccessibilityElement = true
        //        aboutNutrical.accessibilityTraits = .none
        
        foodDiaryLabel.font = .preferredFont(forTextStyle: .largeTitle)
        foodDiaryLabel.adjustsFontForContentSizeCategory = true
        
        dateButton.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        dateButton.titleLabel?.adjustsFontForContentSizeCategory = true
        
        breakfastButton.titleLabel?.font = .preferredFont(forTextStyle: .title1)
        breakfastButton.titleLabel?.adjustsFontForContentSizeCategory = true
        lunchButton.titleLabel?.font = .preferredFont(forTextStyle: .title1)
        lunchButton.titleLabel?.adjustsFontForContentSizeCategory = true
        dinnerButton.titleLabel?.font = .preferredFont(forTextStyle: .title1)
        dinnerButton.titleLabel?.adjustsFontForContentSizeCategory = true
        
    }
}
