//
//  FoodList+CoreDataProperties.swift
//  FoodCalc
//
//  Created by Muhammad Raihan on 24/05/20.
//  Copyright © 2020 Muhammad Raihan M. All rights reserved.
//

import Foundation
import CoreData

extension FoodItems {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItems> {
        return NSFetchRequest<FoodItems>(entityName: "FoodItems")
    }

    @NSManaged public var foodCalories: String?
    @NSManaged public var foodName: String?
    @NSManaged public var foodType: String?
    @NSManaged public var createdAt: Date
}
