//
//  RecipeDetailView.swift
//  WhatsCooking
//
//  Created by Sajid Javed on 21/10/2020.
//

import Foundation


import SwiftUI

struct FeedsDetailView: View {
    @ObservedObject var manager: RecipeManager
    @State var isIngredient = true
    public var viewSpace: Namespace.ID
    
    var cameFromExplore: Bool = false
    
    var body: some View {
        ZStack {
            
            
            Color.lightBackground
                .ignoresSafeArea()
                .transition(.move(edge: .bottom))
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    // recipe image view
                    RecipeInteractionView(recipeLocal: manager.selectedRecipe ?? manager.mainViewModel.recipesLocal[0], index: manager.currentRecipeIndex, count: manager.mainViewModel.recipesLocal.count, manager: manager, viewSpace: viewSpace)
                        .offset(y : -80)
                    Group {
                        // title
                        Text(manager.selectedRecipe?.strMeal ?? "?")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                        // info view
                        HStack(spacing: 32) {
                            HStack(spacing: 12) {
                                Image(systemName: manager.getCurrentRecipe().cookingInfo.timeImage)
                                    .foregroundColor(.red)
                                //summary[time will take]
                                Text("\(manager.selectedRecipe?.cookingInfo.time ?? "32" ) mins" )
                                    
                            }
                            
                            HStack(spacing: 12) {
                                Image(systemName: manager.getCurrentRecipe().cookingInfo.ingredientCountImage)
                                    .foregroundColor(.red)
                                Text("\(manager.selectedRecipe?.cookingInfo.ingredientCount ?? "7") Ingredients" )
                                    
                            }
                        }
                        .foregroundColor(.black)
                        .padding(.vertical)
                    }
                    .padding(.horizontal)
                    
                    // ingredient/step toggle view
                    Toggle(isOn: $isIngredient, label: {})
                        .toggleStyle(IngredientMethodToggleStyle())
                        .foregroundColor(.black)
                    
                    if isIngredient {
                        // ingredient list
                        IngredientListView(ingredients: manager.selectedRecipe?.ingredients ?? [IngredientsLocal(ingredient: "Ingredients", measure: "Missing", isAvailable: false)])
                    } else {
                        // steps list
                        
                        
                        MethodListView(methods: manager.selectedRecipe?.strInstructions ?? ["Instructions Missing"])
                            .foregroundColor(.black)
                    }
                }
            }
            
            if !cameFromExplore{
                BackButtonView(manager: manager)
                    .foregroundColor(.black)
            }
           
            
        }
    }
}

//need a back button to go back
struct BackButtonView: View {
    @ObservedObject var manager: RecipeManager
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    manager.selectedRecipe = nil
                }
            }, label: {
                HStack {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .bold))
                        .padding(24)
                    
                    Spacer()
                }
            })
            
            Spacer()
        }
    }
}

struct IngredientMethodToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return
            VStack(alignment: .leading) {
                HStack {
                    Text("INGREDIENTS")
                        .font(.system(size: 16, weight: configuration.isOn ? .bold : .regular))
                        .frame(width: 110)
                        .fixedSize()
                        .animation(nil)
                        .padding(4)
                        .padding(.leading, 12)
                        .foregroundColor(.black)
                        .onTapGesture {
                            withAnimation {
                                configuration.isOn = true
                            }
                        }
                    
                    Text("METHOD")
                        .font(.system(size: 16, weight: configuration.isOn ? .regular : .bold))
                        .animation(nil)
                        .padding(4)
                        .foregroundColor(.black)
                        .onTapGesture {
                            withAnimation {
                                configuration.isOn = false
                            }
                        }
                }
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 3)
                    
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: configuration.isOn ? 110 : 70, height: 3)//110 : 70
                        .offset(x: configuration.isOn ? 16 : 140)//0 : 115
                }
            }
    }
}

struct IngredientListView: View {
//    @ObservedObject var manager: RecipeManager
    @State var ingredients: [IngredientsLocal]
    var body: some View {
        ForEach(0..<ingredients.count) { i in
            Toggle(isOn: Binding<Bool>(
                get: { ingredients[i].isAvailable },
                set: { self.ingredients[i].isAvailable = $0 }
            ),
                   label: {
                    Text("\(ingredients[i].measure) \(ingredients[i].ingredient)")
//                        .foregroundColor(manager.currentRecipeIndex%2 == 0 ? .black : .white)
                        .foregroundColor(.black)
            })
            .toggleStyle(CircularToggleStyle())
            .padding(.vertical, 8)
        }
    }
}

struct CircularToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return
            HStack(alignment: .top) {
                ZStack {
                    Circle()
                        .stroke(configuration.isOn ? Color.red : Color.gray.opacity(0.5), lineWidth: 2)
                        .frame(width: 20, height: 20)
                    
                    if configuration.isOn {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.horizontal)
                
                configuration.label
            }.onTapGesture {
                withAnimation {
                    configuration.isOn.toggle()
                }
            }
    }
}

struct MethodListView: View {
    let methods: [String]
    var body: some View {
        ForEach(methods, id: \.self) { value in
            Text("\u{2022} \(value)")
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.vertical, 4)
        }
    }
}


struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
