//
//  MainViewModel.swift
//  WhatsCooking
//
//  Created by Sajid Javed on 22/10/2020.
//

import UIKit
import Alamofire
import Combine

class MainViewModel: ObservableObject {
    //Viewmodel will contain all transaction methods with API and CoreData
    
    @Published var recipesLocal: [RecipeLocal] = []
    @Published var loading = false
    
    
    static var shared = MainViewModel()

    
    init() {
        getLatestMeals()
    }
    
    let mealsUrl = "https://rapidapi.p.rapidapi.com/latest.php"
    
    
    
    //completion: @escaping([Recipe]?, Error?) -> ()
    func getLatestMeals(){
        print("GetLatestMeals Called")
//        self.loading = true

        
        let parameters: Parameters = [
            "x-rapidapi-host": "themealdb.p.rapidapi.com",
            "x-rapidapi-key": "47f799da7amshad47aaa47be4696p1af21bjsn746d39417ee2"
        ]
        
        let headers : HTTPHeaders = [
            "x-rapidapi-host": "themealdb.p.rapidapi.com",
            "x-rapidapi-key": "47f799da7amshad47aaa47be4696p1af21bjsn746d39417ee2"
        ]
        
        AF.request(mealsUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                switch response.result {
                case let .success(value):
                    //decode data
                    
                    guard let data = response.data else {return}
                    
                    do{
                        let decodeJSON = JSONDecoder()
                        decodeJSON.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try decodeJSON.decode(Dishes.self, from: data)
                        
                        
                        self.recipesLocal = EntityMapper.shared.getRecipeLocalArr(recipes: result.meals)
                        self.loading = true

                        print("recipes in viewmodel : \(self.recipesLocal.count)")
                        print("Request Finished : Loading Toggled : \(self.loading)")

                        
                    }catch let jsonErr{
                        print("Json Error : \(jsonErr.localizedDescription)")
                    }
                    
                                            
                    
                    
                    
                    
                    
                    print(value)
                case let .failure(error):
//                    completion(nil, error)
                    print(error)
            }
        }
    }
}

extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

}
