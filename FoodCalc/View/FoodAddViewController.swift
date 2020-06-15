//
//  FoodAddViewController.swift
//  FoodCalc
//
//  Created by Muhammad Raihan on 27/05/20.
//  Copyright © 2020 Muhammad Raihan M. All rights reserved.
//

import UIKit
import CoreData

class FoodAddViewController: UIViewController {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var caloriesField: UITextField!
    @IBOutlet weak var fatsField: UITextField!
    @IBOutlet weak var carbsField: UITextField!
    @IBOutlet weak var proteinField: UITextField!
    
    var foods = [FoodCD]()
    var managedObjectContext: NSManagedObjectContext?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var totalKal:Float = 0
    var foodType:String = ""
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = appDelegate?.persistentContainer.viewContext
        print(foodType)
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func addButtonPressed(_ sender: UIButton) {
        addData()
        print(foods)
        dismiss(animated: true)
    }
    
    func addData(){
        let entity = NSEntityDescription.entity(forEntityName: "FoodCD", in: managedObjectContext!)
        let newFood = NSManagedObject(entity: entity!, insertInto: managedObjectContext!)
        
        if let name = nameField.text{
            newFood.setValue(name, forKey: "name")
        }
        
        newFood.setValue(foodType, forKey: "type")
        
        newFood.setValue(Date(), forKey: "date")
        
        if let calories = Float(caloriesField.text!){
            newFood.setValue(calories, forKey: "calories")
        }
        
        if let fats = Float(fatsField.text!){
            newFood.setValue(fats, forKey: "fats")
        }
        
        if let carbs = Float(carbsField.text!){
            newFood.setValue(carbs, forKey: "carbs")
        }
        
        if let protein = Float(proteinField.text!){
            newFood.setValue(protein, forKey: "protein")
        }
        
        
        do {
            try managedObjectContext?.save()
            print("saved \(newFood)")
        }catch let error as NSError{
            print("Couldnot save \(error)")
        }
    }

}
