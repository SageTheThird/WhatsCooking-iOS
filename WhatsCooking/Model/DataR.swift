//
//  DataR.swift
//  WhatsCooking
//
//  Created by Sajid Javed on 22/10/2020.
//

import Foundation



//build a model for data {latest meals for now}
struct DataR: Decodable{
    
}


//for latest meals end-point
class Dishes:ObservableObject, Decodable{
    
    var meals = [Recipe]()
    
    
}


class Recipe : ObservableObject, Decodable{
    
    var idMeal : String?
    var strMeal : String
    var strDrinkAlternate : String?
    var strCategory : String?
    var strArea : String?
    var strInstructions : String?
    var strMealThumb : String?
    var strTags : String?
    var strYoutube : String?
    var strIngredient1 : String?
    var strIngredient2 : String?
    var strIngredient3 : String?
    var strIngredient4 : String?
    var strIngredient5 : String?
    var strIngredient6 : String?
    var strIngredient7 : String?
    var strIngredient8 : String?
    var strIngredient9 : String?
    var strIngredient10 : String?
    var strIngredient11 : String?
    var strIngredient12 : String?
    var strIngredient13 : String?
    var strIngredient14 : String?
    var strIngredient15 : String?
    var strIngredient16 : String?
    var strIngredient17 : String?
    var strIngredient18 : String?
    var strIngredient19 : String?
    var strIngredient20 : String?
    var strMeasure1 : String?
    var strMeasure2 : String?
    var strMeasure3 : String?
    var strMeasure4 : String?
    var strMeasure5 : String?
    var strMeasure6 : String?
    var strMeasure7 : String?
    var strMeasure8 : String?
    var strMeasure9 : String?
    var strMeasure10 : String?
    var strMeasure11 : String?
    var strMeasure12 : String?
    var strMeasure13 : String?
    var strMeasure14 : String?
    var strMeasure15 : String?
    var strMeasure16 : String?
    var strMeasure17 : String?
    var strMeasure18 : String?
    var strMeasure19 : String?
    var strMeasure20 : String?
    var strSource : String?
    var dateModified : String?

}



class RecipeLocal: Identifiable{
    var idMeal : String?
    var strMeal : String?
    var strDrinkAlternate : String?
    var strCategory : String?
    var strArea : String?
    var strInstructions : [String] = []
    var strMealThumb : String = ""
    var strTags : String?
    var strYoutube : String?
    var ingredients : [IngredientsLocal] = []
    var strSource : String?
    var dateModified : String?
    var cookingInfo = CookingInfo()
    
    
    public init(){
        
    }
    
    
//
//    init(idMeal:String, strMeal:String, strDrinkAlternate:String, strCategory:String, strArea:String, strInstructions:[String], strMealThumb:String, strTags:String, strYoutube:String, ingredients:[IngredientsLocal], strSource:String, dateModified:String, cookingInfo:CookingInfo) {
//        self.idMeal = idMeal
//        self.strMeal = strMeal
//        self.strDrinkAlternate = strDrinkAlternate
//        self.strCategory = strCategory
//        self.strArea = strArea
//        self.strInstructions = strInstructions
//        self.strMealThumb = strMealThumb
//        self.strTags = strTags
//        self.strYoutube = strYoutube
//        self.ingredients = ingredients
//        self.strSource = strSource
//        self.dateModified = dateModified
//        self.cookingInfo = cookingInfo
//        
//    }
}


struct IngredientsLocal{
    var ingredient: String = ""
    var measure: String = ""
    var isAvailable:Bool = false
    
    init(ingredient: String, measure: String, isAvailable: Bool) {
        self.ingredient = ingredient
        self.measure = measure
        self.isAvailable = isAvailable
    }
}


class CookingInfo: Identifiable{
    
    var difficulty = ""
    var difficultyImage = ""
    var time = ""
    var timeImage = ""
    var type = ""
    var typeImage = ""
    var ingredientCount = ""
    var ingredientCountImage = ""

}
