//
//  EntityMapper.swift
//  WhatsCooking
//
//  Created by Sajid Javed on 24/10/2020.
//

import Foundation

//Responsible for mapping Recipe(Api) to RecipeLocal(in-App use)
class EntityMapper{
    
    
    static var shared = EntityMapper()


    func getRecipeLocalArr(recipes: [Recipe]) -> [RecipeLocal] {

        var recipesLocal = [RecipeLocal]()
        
        
        for recipe in recipes{
            recipesLocal.append(getRecipeLocal(for: recipe))
        }

        return recipesLocal
    }

    func getRecipeLocal(for recipe: Recipe) -> RecipeLocal {

        let recipeLocal = RecipeLocal()
        recipeLocal.idMeal = recipe.idMeal
        recipeLocal.strMeal = recipe.strMeal
        recipeLocal.strDrinkAlternate = recipe.strDrinkAlternate
        recipeLocal.strCategory = recipe.strCategory
        recipeLocal.strArea = recipe.strArea
        //build strInstructions Arr
        recipeLocal.strInstructions =  getInstructionsArr(for : recipe.strInstructions ?? "")//
        recipeLocal.strMealThumb = recipe.strMealThumb ?? "We Don't Have Title For This One"
        recipeLocal.strTags = recipe.strTags
        recipeLocal.strYoutube = recipe.strYoutube
        //build ingredientsMeasure Arr
        recipeLocal.ingredients = getIngredientsMeasureArr(for: recipe)
        recipeLocal.strSource = recipe.strSource
        recipeLocal.dateModified = recipe.dateModified
        addCookingInfo(from: recipe, to: recipeLocal)
        
        
        return recipeLocal
    }
    
    func addCookingInfo(from recipe:Recipe, to recipeLocal: RecipeLocal){
        
        recipeLocal.cookingInfo.difficulty = CookingDifficulty.allCases.randomElement()?.rawValue ?? "Easy" // here provide 3 options and pick at random
        recipeLocal.cookingInfo.difficultyImage = "x.squareroot"
//        recipeLocal.cookingInfo.time = String(arc4random_uniform(45) + 22)
        recipeLocal.cookingInfo.time = String((recipeLocal.ingredients.count * 4) + 5)
        recipeLocal.cookingInfo.timeImage = "alarm"
        recipeLocal.cookingInfo.type = recipe.strCategory ?? "Fish"
        recipeLocal.cookingInfo.typeImage = "leaf"
        recipeLocal.cookingInfo.ingredientCount = String(recipeLocal.ingredients.count)
        recipeLocal.cookingInfo.ingredientCountImage = "chart.bar.doc.horizontal"
        
    }
    
    
    enum CookingDifficulty: String,CaseIterable {

        case Easy = "Easy"
        case Medium = "Medium"
        case Hard = "Hard"

    }
    
    
    func getIngredientsMeasureArr(for recipe: Recipe) -> [IngredientsLocal]{
        var ingredients = [IngredientsLocal]()
        
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient1 ?? "", measure: recipe.strMeasure1 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient2 ?? "", measure: recipe.strMeasure2 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient3 ?? "", measure: recipe.strMeasure3 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient4 ?? "", measure: recipe.strMeasure4 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient5 ?? "", measure: recipe.strMeasure5 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient6 ?? "", measure: recipe.strMeasure6 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient7 ?? "", measure: recipe.strMeasure7 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient8 ?? "", measure: recipe.strMeasure8 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient9 ?? "", measure: recipe.strMeasure9 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient10 ?? "", measure: recipe.strMeasure10 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient11 ?? "", measure: recipe.strMeasure11 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient12 ?? "", measure: recipe.strMeasure12 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient13 ?? "", measure: recipe.strMeasure13 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient14 ?? "", measure: recipe.strMeasure14 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient15 ?? "", measure: recipe.strMeasure15 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient16 ?? "", measure: recipe.strMeasure16 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient17 ?? "", measure: recipe.strMeasure17 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient18 ?? "", measure: recipe.strMeasure18 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient19 ?? "", measure: recipe.strMeasure19 ?? "", isAvailable: true))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient20 ?? "", measure: recipe.strMeasure20 ?? "", isAvailable: true))
        
        let nonEmptyIngredients = ingredients.filter({
            $0.ingredient != ""
        })
        
        return nonEmptyIngredients
    }
    
    
    func getInstructionsArr(for instructions: String) -> [String]{
        //breaks down instructions string into instructions array by . and :
//        let str = instructions.replacingOccurrences(of: "\n", with: "")
//        let str2 = str.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: .punctuationCharacters)
//        print("Modified String : \(str2)")
//        let nonEmptyInstructions = instructions.components(separatedBy: [".", ":"]).filter({
//            $0 != ""
//        })
        return instructions.components(separatedBy: [".", ":"])
    }

}
