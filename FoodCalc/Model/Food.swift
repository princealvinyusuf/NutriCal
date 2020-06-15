//
//  Food.swift
//  FoodCalc
//
//  Created by Muhammad Raihan on 22/05/20.
//  Copyright © 2020 Muhammad Raihan M. All rights reserved.
//

import Foundation

struct Food {
    let name:String
    let calories:Double
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String,Any)
    }
    
    init (json:[String:Any]) throws {
        guard let name = json["item_name"] as? String else{ throw SerializationError.missing("Food name is Missing")}
        guard let calories = json["nf_calories"] as? Double else {throw SerializationError.missing("Calories is Missing")}
        
        self.name = name
        self.calories = calories
    }
    
    static let basePath = "https://api.nutritionix.com/v1_1/search/Steak?results=0:20&fields=item_name,brand_name,item_id,nf_calories&appId=85ddc507&appKey=88a66314dc0210e0e17e4788eb2d1421"
    static func foodList (withFoodName food:String, completion: @escaping ([Food]) -> ()){
        let url = basePath
        let request =  URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: request){ (data:Data?, response:URLResponse?, error:Error?)in
            
            var foodArray:[Food] = []
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                        if let foodHits = json["hits"] as? [String:Any]{
                            if let foodData = foodHits["fields"] as? [[String:Any]] {
                                for dataPoint in foodData {
                                    if let foodObject = try? Food(json: dataPoint){
                                        foodArray.append(foodObject)
                                        print(data)
                                    }
                                }
                            }
                        }
                    }
                }catch{
                    print (error.localizedDescription)
                }
                
                completion(foodArray)
            }
        }
        task.resume()
        
        
        
    }
}
