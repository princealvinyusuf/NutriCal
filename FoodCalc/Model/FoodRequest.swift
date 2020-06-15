////
////  FoodRequest.swift
////  FoodCalc
////
////  Created by Muhammad Raihan on 23/05/20.
////  Copyright © 2020 Muhammad Raihan M. All rights reserved.
////
//
//import Foundation
//
//enum FoodError:Error{
//    case noDataAvailable
//    case canNotProcessData
//}
//struct FoodRequest {
//    let resourceURL:URL
//    let API_KEY = "a3f62ce108758643c5d03251caf9d102"
//    let API_KEY2 = "88a66314dc0210e0e17e4788eb2d1421"
//    let APP_ID = "e65f0253"
//    let APP_ID2 = "85ddc507"
//    
//    init(foodName: String){
//        let resourceString = "https://api.edamam.com/api/food-database/parser?ingr=\(foodName)&app_id=\(APP_ID)&app_key=\(API_KEY)&page=0"
//        let resourceString2 = "https://api.nutritionix.com/v1_1/search/\(foodName)?results=0:20&fields=item_name,brand_name,item_id,nf_calories&appId=\(APP_ID2)&appKey=\(API_KEY2)"
//
//        guard let resourceURL = URL(string: resourceString2) else {fatalError()}
//        self.resourceURL = resourceURL
//    }
//    
//    func getFoods (completion: @escaping(Result<[FoodDetail], FoodError>)-> Void ){
//        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
//            guard let jsonData = data else {
//                completion(.failure(.noDataAvailable))
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                let foodResponse = try decoder.decode(FoodResponse.self, from: jsonData)
//                let foodDetails = foodResponse.hits.fi
//                completion(.success(foodDetails))
//            }catch{
//                completion(.failure(.canNotProcessData))
//            }
//        }
//        dataTask.resume()
//        
//    }
//}
