//
//  EntityMapper.swift
//  WhatsCooking
//
//  Created by Sajid Javed on 24/10/2020.
//

import Foundation

//'Local' means the model is mapped from api response to local object

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
        
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient1 ?? "", measure: recipe.strMeasure1 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient2 ?? "", measure: recipe.strMeasure2 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient3 ?? "", measure: recipe.strMeasure3 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient4 ?? "", measure: recipe.strMeasure4 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient5 ?? "", measure: recipe.strMeasure5 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient6 ?? "", measure: recipe.strMeasure6 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient7 ?? "", measure: recipe.strMeasure7 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient8 ?? "", measure: recipe.strMeasure8 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient9 ?? "", measure: recipe.strMeasure9 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient10 ?? "", measure: recipe.strMeasure10 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient11 ?? "", measure: recipe.strMeasure11 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient12 ?? "", measure: recipe.strMeasure12 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient13 ?? "", measure: recipe.strMeasure13 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient14 ?? "", measure: recipe.strMeasure14 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient15 ?? "", measure: recipe.strMeasure15 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient16 ?? "", measure: recipe.strMeasure16 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient17 ?? "", measure: recipe.strMeasure17 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient18 ?? "", measure: recipe.strMeasure18 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient19 ?? "", measure: recipe.strMeasure19 ?? "", isAvailable: false))
        ingredients.append(IngredientsLocal(ingredient: recipe.strIngredient20 ?? "", measure: recipe.strMeasure20 ?? "", isAvailable: false))
        
        //removes the empty ingredients
        let nonEmptyIngredients = ingredients.filter({
            $0.ingredient != ""
        })
        
        return nonEmptyIngredients
    }
    
    
    func getInstructionsArr(for instructions: String) -> [String]{
        //breaks down instructions string into instructions array by . and :
        return instructions.components(separatedBy: "\n")
    }

}
