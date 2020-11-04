//
//  ExploreExtededView.swift
//  WhatsCooking
//
//  Created by Sajid Javed on 29/10/2020.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI

struct ExploreExtendedView : View{
    
    
    var parameter:String = ""
    var type:String = ""
    
    @ObservedObject var mainViewModel = MainViewModel.shared
    @ObservedObject var manager = RecipeManager()
    @Namespace private var viewSpace: Namespace.ID
    @State var data: [FilterMeals] = []
    @State private var gotToFeedsDetailView: Bool = false
    @State var isItemLoading = false
    
    var body: some View{
        
        ScrollView{
            
            
                ForEach(data, id: \.idMeal){item in
                    //Empty Nav Link to trigger next view
                    
                    NavigationLink(destination: FeedsDetailView(manager: manager, viewSpace: viewSpace, cameFromExplore: true), isActive: self.$gotToFeedsDetailView){

                        EmptyView()
                    }
                    //Grid Item goes here
                    
                    RowItemEE(item: item, viewSpace: viewSpace, manager: manager, isItemLoading: $isItemLoading)
                        .shadow(color: Color.gray,
                                radius: 3.0,
                                x: CGFloat(10),
                                y: CGFloat(10))
                        .onTapGesture{
                            isItemLoading = true
                            mainViewModel.getMealDetailsById(for: item.idMeal, completion: { recipeLocal, error in
                                
                                if let error = error {
                                    print(error)
                                }
                                if let recipeLocal = recipeLocal {
                                    
                                    manager.selectedRecipe = recipeLocal
                                    isItemLoading = false
                                    self.gotToFeedsDetailView.toggle()
                                    
                                    
                                }
                                
                            })
                        }
                    
                    
                
            }
            
            

        }.onAppear{
            if(type == Tags.cuisines.rawValue){
                mainViewModel.filterMealsByArea(area: parameter, completion: {filteredMeals, error in
                    
                    if let error = error{
                        print("\(error)")
                    }
                    
                    if let filteredMeals = filteredMeals{
                        data = filteredMeals
                    }
                    
                })
            }
            
            if(type == Tags.genres.rawValue){
                mainViewModel.filterMealsByCategory(category: parameter, completion: {filteredMeals, error in
                    
                    if let error = error{
                        print("\(error)")
                    }
                    
                    if let filteredMeals = filteredMeals{
                        data = filteredMeals
                    }
                    
                })
            }
            
        }
        
        
    }
}


struct RowItemEE:View{
    
    var item: FilterMeals
    var viewSpace: Namespace.ID
    var manager: RecipeManager
    let cardColor : Color = Color.red
    
    @Binding var isItemLoading: Bool
    
    var body: some View{
        
        
        
        HStack{
            //root hstack
            
            //Vstack - title, id
            VStack(alignment: .leading){
                Text("#\(item.idMeal)")
                    .font(.system(size: 15))
                    .font(.callout).bold()
                    .foregroundColor(.white)
                    .background(Color.yellow)


                Text("\(item.strMeal)")
                    .fontWeight(.bold)
                    .font(.system(.largeTitle, design: .rounded))
//                    .font(.callout).bold()
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
//                    .background(Color.black)
                    .opacity(0.95)
//                    .cornerRadius(10)
                
                if isItemLoading{
                    withAnimation{
                        ProgressView()
                    }
                }
                
                
                
                
            }//Vstack
            .frame(width: 200)
            
            
            
            //Image
            if let imageUrl = item.strMealThumb  {
                if let url = URL(string: imageUrl){
                    
                    KFImage(url)
                                .resizable()
                                .cancelOnDisappear(true)
                                .placeholder{
                                    Image("meal_1")
                                }
                                .overlay(Circle()
                                            .stroke(Color.white, lineWidth: 14))
                                .aspectRatio(contentMode: .fill)
                        .frame(width: 260, height: 260)
                                .clipShape(Circle())
                                .scaledToFit()
                        
                        .offset(x: UIScreen.screenWidth / 2 - 140)

            }
            }
            
            
            
        }
        .background(cardColor)
        .cornerRadius(10)
        .frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading)
        .padding()

        
        
    }
}



struct ExploreExtendedView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreExtendedView(parameter: "Canadian", type: "Cuisines")
        }
}

extension Color {
    static var random: Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
}
