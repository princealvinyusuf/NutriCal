//
//  FoodListCoreData.swift
//  FoodCalc
//
//  Created by Muhammad Raihan on 24/05/20.
//  Copyright © 2020 Muhammad Raihan M. All rights reserved.
//

import Foundation
import CoreData

public class FoodListCoreData: NSManagedObject, Identifiable {
    @NSManaged public var createdAt:Date?
    @NSManaged public var foodName:String?
}

extension FoodListCoreData{
    static func getAllFoodItems() -> NSFetchRequest<FoodListCoreData>{
        let request:NSFetchRequest<FoodListCoreData> = FoodListCoreData.fetchRequest() as! NSFetchRequest<FoodListCoreData>
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        
        request.sortDescriptor = [sortDescriptor]
        
        return request
    }
}
