//
//  RecipeManager.swift
//  WhatsCooking
//
//  Created by Sajid Javed on 21/10/2020.
//

import Foundation


import SwiftUI

// next lets add a viewModel
class RecipeManager: ObservableObject {
    
    @ObservedObject var mainViewModel = MainViewModel.shared
    
    
    
    @Published var selectedRecipe: RecipeLocal? = nil
    //@Published var selectedRecipe: RecipeItem? = Data.recipes[0]
    @Published var swipeHeight: CGFloat = 0.0
    
    var currentRecipeIndex = 0
    
    func chageSwipeValue(value: CGFloat) {
        swipeHeight = value/3
    }
    
    func swipeEnded(value: CGFloat) {
        if value/3 > 20 || value/3 < -20 {
            var isChanged = false
            if swipeHeight > 0 {
                if currentRecipeIndex > 0 {
                    currentRecipeIndex -= 1
                    swipeHeight = 360.0
                    isChanged = true
                }
            } else if swipeHeight < 0 {
                if currentRecipeIndex < mainViewModel.recipesLocal.count - 1 {
                    currentRecipeIndex += 1
                    swipeHeight = -360.0
                    isChanged = true
                }
            }
            
            if isChanged {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.swipeHeight = 0.0
                }
            } else {
                swipeHeight = 0.0
            }
        } else {
            swipeHeight = 0.0
        }
    }
    
    func getCurrentRecipe() -> RecipeLocal {
        
        
//        let recipeLocal = EntityMapper.shared.getRecipeLocalArr(recipes: [$mainViewModel.recipesLocal[currentRecipeIndex].wrappedValue])
//
//        for recipe in recipeLocal {
//
//            print("Cooking Info")
//            print("Difficulty : \(recipe.cookingInfo.difficulty)")
//            print("DifficultyImage : \(recipe.cookingInfo.difficultyImage)")
//            print("Time : \(recipe.cookingInfo.time)")
//            print("TimeImage : \(recipe.cookingInfo.timeImage)")
//            print("Type : \(recipe.cookingInfo.type)")
//            print("TypeImage : \(recipe.cookingInfo.typeImage)")
//            print("IngredientsCount : \(recipe.cookingInfo.ingredientCount)")
//            print("IngredientsCountImage : \(recipe.cookingInfo.ingredientCountImage)")
//            
//        }
       
        return $mainViewModel.recipesLocal[currentRecipeIndex].wrappedValue
    }
}

struct RecipeManager_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
