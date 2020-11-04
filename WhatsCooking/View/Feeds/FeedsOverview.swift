//
//  RecipeOveriew.swift
//  WhatsCooking
//
//  Created by Sajid Javed on 21/10/2020.
//

import Foundation
import KingfisherSwiftUI

import SwiftUI

struct FeedsOverview: View {
    @ObservedObject var manager: RecipeManager
    public var viewSpace: Namespace.ID
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Spacer()
            // title view
            TitleView(manager: manager)
            ZStack {
                // interaction view with image
                RecipeInteractionView(recipeLocal: manager.getCurrentRecipe(), index: manager.currentRecipeIndex, count: manager.mainViewModel.recipesLocal.count, manager: manager, viewSpace: viewSpace)
                    .rotationEffect(.degrees(Double(-manager.swipeHeight)))
                    .offset(x: UIScreen.screenWidth / 2)
                HStack {
                    // summery view
                    SummeryView(recipeLocal: manager.getCurrentRecipe())
                        .foregroundColor(manager.currentRecipeIndex%2 == 0 ? .black : .white)
                    Spacer()
                }
            }
            // descreiption view
            DescriptionView(manager: manager)

            Spacer()
        }
    }
}




struct TitleView: View {
    @ObservedObject var manager: RecipeManager
    var body: some View {
        Text("Trending Recipes Of The Day")
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.gray)
            
        
        //meal title
            Text(manager.getCurrentRecipe().strMeal ?? "Trouble Loading But We're On It")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)

    }
}

struct SummeryView: View {
    let recipeLocal: RecipeLocal
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {//spacing between individual info
            //Summary section to the left
            
            HStack(spacing: 12) {//horizantal spacing between info
                Image(systemName: recipeLocal.cookingInfo.timeImage)
                    .foregroundColor(Color(.systemRed))
                Text("\(recipeLocal.cookingInfo.time) mins")
                    .foregroundColor(.black)
            }
            
            
            HStack(spacing: 12) {//horizantal spacing between info
                Image(systemName: recipeLocal.cookingInfo.typeImage)
                    .foregroundColor(Color(.systemRed))
                Text(recipeLocal.cookingInfo.type)
                    .foregroundColor(.black)
            }
            
            HStack(spacing: 12) {//horizantal spacing between info
                Image(systemName: recipeLocal.cookingInfo.ingredientCountImage)
                    .foregroundColor(Color(.systemRed))
                Text("\(recipeLocal.cookingInfo.ingredientCount) Ingredients")
                    .foregroundColor(.black)
            }
            
            HStack(spacing: 12) {//horizantal spacing between info
                Image(systemName: recipeLocal.cookingInfo.difficultyImage)
                    .foregroundColor(Color(.systemRed))
                Text(recipeLocal.cookingInfo.difficulty)
                    .foregroundColor(.black)
            }
            
            HStack(spacing: 12) {
                Image(systemName: "chart.bar.doc.horizontal")
                    .foregroundColor(Color(.systemRed))
                Text("Healthy")
                    .foregroundColor(.black)
            }
        }
        .font(.system(size: 17, weight: .semibold))
    }
}

struct DescriptionView: View {
    @ObservedObject var manager: RecipeManager
    var body: some View {
        HStack(spacing: 12) {
            //bottom description of recipe
            Text("There’s cooking, and then there’s cooking with passion, creativity, and love. At What's Cooking, we firmly believe that the energy you put into a recipe is just as important as the ingredients you use. And we’re not alone.")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    manager.selectedRecipe = manager.getCurrentRecipe()
                    
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemRed))
                        .frame(width: 50, height: 50)
                        .rotationEffect(.degrees(45))
                    
                    Image(systemName: "arrow.right")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }
            })
            
            
        }
        .padding(.bottom, 13)
    }
}

struct RecipeInteractionView: View {
    let recipeLocal: RecipeLocal
    let index: Int
    let count: Int
    @ObservedObject var manager: RecipeManager
    //lets add some matched geometry effect
    public var viewSpace: Namespace.ID
       var body: some View {
        ZStack {
            Circle()
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.lightBackground.opacity(0.1),
                            Color.red, Color.red
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing),
                    lineWidth: 4
                )
                .scaleEffect(1.15)
                .matchedGeometryEffect(id: "borderId", in: viewSpace, isSource: true)
            
            ArrowShape(reachedTop: index == 0, reachedBottom: index == count - 1)
                .stroke(Color.gray,
                        style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                .frame(width: UIScreen.screenWidth - 32, height: UIScreen.screenWidth - 32)
                .scaleEffect(1.15)
                .matchedGeometryEffect(id: "arrowId", in: viewSpace, isSource: true)
            
//            guard let thumb = recipe.strMealThumb else { return }
            if let imageUrl = recipeLocal.strMealThumb  {
                if let url = URL(string: imageUrl){
                    
                    KFImage(url)
                                .resizable()
                                .cancelOnDisappear(true)
                                .placeholder{
                                    Image("meal_1")
                                }
                                .overlay(Circle()
                                .stroke(Color(.systemRed), lineWidth: 6))
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 350, height: 350)
                                .clipShape(Circle())
                                .scaledToFit()
                                .matchedGeometryEffect(id: "imageId", in: viewSpace, isSource: true)
            }
            }

            
            
            // this circle will be used to drag interaction
            Circle()
                .fill(Color.black.opacity(0.001))
                .scaleEffect(1.2)//1.2
                .gesture(
                    DragGesture(minimumDistance: 10)
                        .onChanged({ value in
                            withAnimation {
                                manager.chageSwipeValue(value: value.translation.height)
                            }
                        })
                        .onEnded({ value in
                            withAnimation {
                                manager.swipeEnded(value: value.translation.height)
                            }
                        })
                )
        }
    }
}

//Rotating Arrow
struct ArrowShape: Shape {
    let reachedTop: Bool
    let reachedBottom: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let startAngle: CGFloat = 160
        let endAngle: CGFloat = 200
        
        let radius = rect.width/2
        
        let startAngleRadian = startAngle * CGFloat.pi / 180
        let endAngleRadian = endAngle * CGFloat.pi / 180
        
        let startPoint1 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius, angle: startAngleRadian)
        
        let endPoint1 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius, angle: endAngleRadian)
        
        path.addArc(
            center: CGPoint(x: radius, y: radius),
            radius: radius,
            startAngle: .degrees(Double(startAngle)),
            endAngle: .degrees(Double(endAngle)),
            clockwise: false)
        
        if !reachedTop {
            let startAngleRadian2 = (startAngle + 4) * CGFloat.pi / 180
            let startPoint2 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius + 8, angle: startAngleRadian2)
            
            let startPoint3 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius - 8, angle: startAngleRadian2)
            
            path.move(to: startPoint1)
            path.addLine(to: startPoint2)
            path.move(to: startPoint1)
            path.addLine(to: startPoint3)
        }
        
        if !reachedBottom {
            let endAngleRadian2 = (endAngle - 4) * CGFloat.pi / 180
            let endPoint2 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius + 8, angle: endAngleRadian2)
            
            let endPoint3 = CGPoint.pointOnCircle(center: CGPoint(x: radius, y: radius), radius: radius - 8, angle: endAngleRadian2)
            
            path.move(to: endPoint1)
            path.addLine(to: endPoint2)
            path.move(to: endPoint1)
            path.addLine(to: endPoint3)
        }
        
        return path
    }
}

struct RecipeOveriew_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}



