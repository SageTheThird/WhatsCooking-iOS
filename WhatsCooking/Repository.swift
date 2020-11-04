//
//  Repository.swift
//  WhatsCooking
//
//  Created by Sajid Javed on 26/10/2020.
//

import Foundation
import Alamofire
import Combine


//Data Entry Point - From API and Core Data(if)
class Repository{
    
    
    
    private enum Urls:String{
        case latestMealsUrl = "https://rapidapi.p.rapidapi.com/latest.php"
        case mealDetailsById = "https://themealdb.p.rapidapi.com/lookup.php"
        case list = "https://themealdb.p.rapidapi.com/list.php?"
        case searchMealsByName = "https://themealdb.p.rapidapi.com/search.php"
        case filterMeals = "https://themealdb.p.rapidapi.com/filter.php"
    }
    
    let headers : HTTPHeaders = [
        "x-rapidapi-host": "themealdb.p.rapidapi.com",
        "x-rapidapi-key": "47f799da7amshad47aaa47be4696p1af21bjsn746d39417ee2"
    ]
    

    
    func fetchLatestMeals(completion : @escaping ([RecipeLocal]?, Error?)->()) -> Void {
        
        
        AF.request(Urls.latestMealsUrl.rawValue, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                switch response.result {
                
                case .success(_):
                    //decode data
                    guard let data = response.data else {return}
                    
                    do{
                        let decodeJSON = JSONDecoder()
                        decodeJSON.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try decodeJSON.decode(Dishes.self, from: data)
                        
                        
                        completion(EntityMapper.shared.getRecipeLocalArr(recipes: result.meals), nil)
                    

                        
                    }catch let jsonErr{
                        completion(nil, jsonErr)
                        print("Json Error : \(jsonErr.localizedDescription)")
                    }

                    
                case let .failure(error):
                    completion(nil, error)
                    print(error)
            }
        }
        
        
    }//fetchLatestMeals End
    
    
    //getMealDetailsById
    func fetchMealDetailsById(for mealId: String, completion : @escaping (RecipeLocal?, Error?)->()) -> Void {
        
        let parameters:Parameters = [
            "i" : mealId
        ]
        
        
        AF.request(Urls.mealDetailsById.rawValue, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                switch response.result {
                
                case .success(_):
                    //decode data
                    guard let data = response.data else {return}
                    
                    do{
                        let decodeJSON = JSONDecoder()
                        decodeJSON.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try decodeJSON.decode(Dishes.self, from: data)
                        
                        
                        completion(EntityMapper.shared.getRecipeLocal(for: result.meals[0]), nil)
                    

                        
                    }catch let jsonErr{
                        completion(nil, jsonErr)
                        print("Json Error : \(jsonErr.localizedDescription)")
                    }

                    
                case let .failure(error):
                    completion(nil, error)
                    print(error)
            }
        }
        
        
    }//fetchMealDetailsById End
    
    
    
    
    //getAllAreas
    func fetchAllAreas() -> [AreaLocal] {
        //already built areas
        return RecipeModel.areasLocal
    }
    
    
    //getAllMealCategories
    func fetchAllMealCategories() -> [MealCategory] {
        //already built areas
        return RecipeModel.mealCategories
    }
    
    
    //searchMealsByName - Explore Searchbar End-Point
    func searchMealsByName(query:String, completion : @escaping ([RecipeLocal]?, Error?)->()) -> Void {
        
        let parameters:Parameters = [
            "s" : query
        ]
        
        AF.request(Urls.searchMealsByName.rawValue, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                switch response.result {
                
                case .success(_):
                    //decode data
                    guard let data = response.data else {return}
                    
                    do{
                        let decodeJSON = JSONDecoder()
                        decodeJSON.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try decodeJSON.decode(Dishes.self, from: data)
                        
                        
                        completion(EntityMapper.shared.getRecipeLocalArr(recipes: result.meals), nil)
                    

                        
                    }catch let jsonErr{
                        completion(nil, jsonErr)
                        print("Json Error : \(jsonErr.localizedDescription)")
                    }

                    
                case let .failure(error):
                    completion(nil, error)
                    print(error)
            }
        }
        
        
    }//searchMealByName End
    
    //filterMealsByArea - When an area is tapped - we hit this end-point to show available recipes for that area
    func filterMealsByArea(area:String, completion : @escaping ([FilterMeals]?, Error?)->()) -> Void {
        
        let parameters:Parameters = [
            "a" : area
        ]
        
        AF.request(Urls.filterMeals.rawValue, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                switch response.result {
                
                case .success(_):
                    //decode data
                    guard let data = response.data else {return}
                    
                    do{
                        let decodeJSON = JSONDecoder()
                        decodeJSON.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try decodeJSON.decode(FilterMealsResult.self, from: data)
                        
                        
                        completion(result.meals, nil)
                    

                        
                    }catch let jsonErr{
                        completion(nil, jsonErr)
                        print("Json Error : \(jsonErr.localizedDescription)")
                    }

                    
                case let .failure(error):
                    completion(nil, error)
                    print(error)
            }
        }
        
        
    }//filterMealsByArea End
    
    //filterMealsByCategory - When a category is tapped - we hit this end-point to show available recipes for that category
    func filterMealsByCategory(category:String, completion : @escaping ([FilterMeals]?, Error?)->()) -> Void {
        
        let parameters:Parameters = [
            "c" : category
        ]
        
        AF.request(Urls.filterMeals.rawValue, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                switch response.result {
                
                case .success(_):
                    //decode data
                    guard let data = response.data else {return}
                    
                    do{
                        let decodeJSON = JSONDecoder()
                        decodeJSON.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try decodeJSON.decode(FilterMealsResult.self, from: data)
                        
                        
                        completion(result.meals, nil)
                    

                        
                    }catch let jsonErr{
                        completion(nil, jsonErr)
                        print("Json Error : \(jsonErr.localizedDescription)")
                    }

                    
                case let .failure(error):
                    completion(nil, error)
                    print(error)
            }
        }
        
        
    }//filterMealsByCategory End
    
    
    
    
        
}
    
    
    
    
    


