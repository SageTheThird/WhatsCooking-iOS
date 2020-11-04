//
//  ExploreEntityMapper.swift
//  WhatsCooking
//
//  Created by Sajid Javed on 29/10/2020.
//

import Foundation


//ExploreView two types of data
//-Cousines (Areas)
//-Meal Types

//this class maps all of the 2 types to be usable in one type [Explore]
class ExploreEntityMapper{
    
    static var shared = ExploreEntityMapper()
    
    func mapExploreToCuisines(areas: [AreaLocal]) -> [Explore]{
        var exploreArr = [Explore]()
        
        for area in areas {
            exploreArr.append(Explore(id: area.id, image: area.image, type: area.strArea, description: area.description))
        }
        
        return exploreArr
    }
    
    
    func mapExploreToMealTypes(mealTypes: [MealCategory]) -> [Explore] {
        var exploreArr = [Explore]()
        
        for mealType in mealTypes {
            exploreArr.append(Explore(id: mealType.id, image: mealType.image, type: mealType.category, description: mealType.description))
        }
        
        return exploreArr
    }
    
    func mapExploreToRecipeLocal(meals: [RecipeLocal]) -> [Explore] {
        var exploreArr = [Explore]()
        
        for meal in meals {
            exploreArr.append(Explore(id: Int(meal.idMeal ?? "Unknown") ?? 1001, image: meal.strMealThumb , type: meal.strCategory ?? "Unknown", description: meal.strArea ?? "Unknown"))
        }
        
        return exploreArr
    }
}
