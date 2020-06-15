//
//  FoodItems.swift
//  FoodCalc
//
//  Created by Muhammad Raihan on 24/05/20.
//  Copyright © 2020 Muhammad Raihan M. All rights reserved.
//

import Foundation
import CoreData

public class FoodItems: NSManagedObject, Identifiable{
    @NSManaged public var createdAt:Date?
    @NSManaged public var foodCalories:String?
    @NSManaged public var foodName:String?
    
}

extension FoodItems{
    static func getAllFoodItems() -> NSFetchRequest<FoodItems>{
        let request:NSFetchRequest<FoodItems> = FoodItems.fetchRequest() as! NSFetchRequest<FoodItems>
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
}
