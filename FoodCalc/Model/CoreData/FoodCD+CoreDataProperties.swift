//
//  FoodCD+CoreDataProperties.swift
//  FoodCalc
//
//  Created by Muhammad Raihan on 24/05/20.
//  Copyright © 2020 Muhammad Raihan M. All rights reserved.
//

import Foundation
import CoreData

extension FoodCD {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodCD> {
        return NSFetchRequest<FoodCD>(entityName: "FoodCD")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var date: String?
    @NSManaged public var calories: NSNumber?
    @NSManaged public var fats: NSNumber?
    @NSManaged public var carbs: NSNumber?
    @NSManaged public var protein: NSNumber?
}
