//
//  FoodAPI.swift
//  FoodCalc
//
//  Created by Muhammad Raihan on 27/05/20.
//  Copyright © 2020 Muhammad Raihan M. All rights reserved.
//

import Foundation

final class FoodAPI{
    
    static let shared = FoodAPI()
    
    func fetchFoodList(name:String, onCompletion: @escaping ([FoodData]) -> ()) {
        let urlString = "https://api.nutritionix.com/v1_1/search/\(name)?results=0:10&fields=item_name,brand_name,item_image,item_id,nf_calories,nf_total_fat,nf_protein,nf_total_carbohydrate&appId=85ddc507&appKey=88a66314dc0210e0e17e4788eb2d1421"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, resp, error) in
            guard let data = data else{
                print ("Data was nil")
                return
            }
            
            guard let FoodArray = try? JSONDecoder().decode(FoodArray.self, from: data) else{
                print ("Couldnt decode json")
                return
                }
            onCompletion(FoodArray.hits)
            
            print(FoodArray.hits)
        }
        task.resume()
    }
    
}



struct FoodArray:Codable {
    let hits: [FoodData]
}

struct FoodData:Codable{
    let _id: String?
    let fields: FoodDetail
}

struct FoodDetail: Codable{
    let item_id: String?
    let item_name: String?
    let nf_calories: Float?
    let nf_total_fat: Float?
    let nf_total_carbohydrate: Float?
    let nf_protein: Float?
}

/*
 "total_hits": 12687,
 "max_score": 12.847387,
 "hits": [
     {
         "_index": "f762ef22-e660-434f-9071-a10ea6691c27",
         "_type": "item",
         "_id": "513fceb575b8dbbc21001bd2",
         "_score": 12.847387,
         "fields": {
             "item_id": "513fceb575b8dbbc21001bd2",
             "item_name": "Steak - 1 steak (yield from 518 g raw meat)",
             "brand_name": "USDA",
             "nf_calories": 814.08,
             "nf_serving_size_qty": 1,
             "nf_serving_size_unit": "serving"
         }
     },
 */
