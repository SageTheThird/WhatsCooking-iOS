//
//  MainViewModel.swift
//  WhatsCooking
//
//  Created by Sajid Javed on 22/10/2020.
//

import UIKit
import Alamofire
import Combine



//Responsible for parsing data from repository and passing it to views

class MainViewModel: ObservableObject {
    
    @Published var recipesLocal: [RecipeLocal] = []
    @Published var loading = false
    
    private var repository = Repository()
    static var shared = MainViewModel()

    
    init() {
        //populates the feeds with init
        getLatestMeals()
    }
    
    
    
    
    
    //Feeds trending meals
    func getLatestMeals(){
        print("GetLatestMeals Called")

        repository.fetchLatestMeals(completion: {recipesLocalApi, error in
            
            if let error = error {
                //handle error
                print(error)
            }
            
            if let recipesLocalApi = recipesLocalApi{
                //handle data fetch success
                
                self.recipesLocal = recipesLocalApi
                self.loading = true
            }
            
        })//fetchLatestMeals
        
}//getLatestMeals End
    
    //Takes mealId and returns all details related to it
    func getMealDetailsById(for mealId:String, completion : @escaping (RecipeLocal?, Error?)->()) -> Void {
        print("Fetching Details For \(mealId)")
        
        repository.fetchMealDetailsById(for: mealId, completion: { recipeLocal, error in
            
            if let error = error {
                //handle error
                print(error)
                completion(nil, error)
            }
            
            if let recipeLocal = recipeLocal{
                //here we have details of mealId
//                self.recipesLocal = [recipeLocal]
//                self.loading = true
                completion(recipeLocal, nil)
                print("Meal Details For \(recipeLocal.strMeal ?? "Nil")")
                
                
            }
            
            
            
        })
        
        
    }//getMealDetailsById End
    
    
    
    //Gets all areas available
    func getAllAreas() -> [AreaLocal]{
        print("Listing Areas")

        return repository.fetchAllAreas()
    }//getMealDetailsById End
    
    
    //Gets all meal categories available
    func getAllMealCategories() -> [MealCategory]{
        print("Listing Meal Categories")

        return repository.fetchAllMealCategories()
    }//getMealDetailsById End
    
    
    func searchMealsByName(query: String, completion : @escaping ([Explore]?, Error?)->()) -> Void {
        print("SearchMealsByName Called")


        repository.searchMealsByName(query: query, completion: {recipesLocalApi, error in
            
            if let error = error {
                //handle error
                completion(nil, error)
                print(error)
            }
            
            if let recipesLocalApi = recipesLocalApi{
                //handle data fetch success
                
                let data = ExploreEntityMapper.shared.mapExploreToRecipeLocal(meals: recipesLocalApi)
                completion(data, nil)
                print("Request Success : Count: \(data.count)")
            }
            
        })//searchMealsByName
        
}//searchMealsByName End
    
    
    func filterMealsByArea(area: String, completion : @escaping ([FilterMeals]?, Error?)->()) -> Void {
        print("filterMealsByArea Called")


        repository.filterMealsByArea(area: area, completion: {filteredMeals, error in
            
            if let error = error {
                //handle error
                completion(nil, error)
                print(error)
            }
            
            if let filteredMeals = filteredMeals{
                //handle data fetch success
                completion(filteredMeals, nil)
                print("Request Success : Count: \(filteredMeals.count)")
            }
            
        })//searchMealsByName
        
}//searchMealsByName End
    
    
    func filterMealsByCategory(category: String, completion : @escaping ([FilterMeals]?, Error?)->()) -> Void {
        print("filterMealsByCategory Called")


        repository.filterMealsByCategory(category: category, completion: {filteredMeals, error in
            
            if let error = error {
                //handle error
                completion(nil, error)
                print(error)
            }
            
            if let filteredMeals = filteredMeals{
                //handle data fetch success
                completion(filteredMeals, nil)
                print("Request Success : Count: \(filteredMeals.count)")
            }
            
        })//filterMealsByCategory
        
}//filterMealsByCategory End
    
    
    
    
    
    
    
    
    
    
}



