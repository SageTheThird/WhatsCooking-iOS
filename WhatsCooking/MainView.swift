//
//  MainView.swift
//  WhatsCooking
//
//  Created by Sajid Javed on 26/10/2020.
//

import Foundation
import SwiftUI


struct MainView: View{
    
    
    @Environment(\.managedObjectContext) private var viewContext

    //Curved Tabbar
    var tabItems = ["Feeds","Explore"]
    @State var selected = "Feeds"
    @State var centerX : CGFloat = 0
    
    
    init() {
        
        UITabBar.appearance().isHidden = true
        
    }
    
    @Environment(\.verticalSizeClass) var size

    var body: some View{
        
        VStack(spacing: 0){
        
        TabView(selection: $selected){
           
                
                
                FeedsView()
                    .tag(tabItems[0])
                
                
                ExploreView()
                    .tag(tabItems[1])

            
           
        }
        
            //Custome Tabbar
            HStack(spacing: 0){
                
                ForEach(tabItems,id: \.self){value in
                    
                    GeometryReader{reader in
                        
                        TabBarButton(selected: $selected, value: value,centerX: $centerX,rect: reader.frame(in: .global))
                            // setting First Intial Curve...
                            .onAppear(perform: {
                                
                                if value == tabItems.first{
                                    centerX = reader.frame(in: .global).midX
                                }
                            })
                            // For Landscape Mode....
                            .onChange(of: size) { (_) in
                                if selected == value{
                                    centerX = reader.frame(in: .global).midX
                                }
                            }
                    }
                    .frame(width: 70, height: 50)
                    
                    if value != tabItems.last{Spacer(minLength: 0)}
                }
            }
            .padding(.horizontal,25)
            .padding(.top)
            // For Smaller Size iPhone Padding Will be 15 And For Notch Phones No Padding
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .background(Color.white.clipShape(AnimatedShape(centerX: centerX)))
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
            .padding(.top,-15)
            .ignoresSafeArea(.all, edges: .horizontal)
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
        
        
        
    }
    
}



struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        MainView()
    }
}

struct TabBarButton : View {
      
      @Binding var selected : String
      var value: String
      @Binding var centerX : CGFloat
      var rect : CGRect
      
      var body: some View{
          
          Button(action: {
              withAnimation(.spring()){
                  selected = value
                  centerX = rect.midX
              }
          }, label: {
              
              VStack{
                  
                  Image(value)
                      .resizable()
                      .renderingMode(.template)
                      .frame(width: 26, height: 26)
                    .foregroundColor(selected == value ? Color(.systemRed) : .gray)
                  
                  Text(value)
                      .font(.caption)
                      .foregroundColor(.black)
                      .opacity(selected == value ? 1 : 0)
              }
              // Deafult Frame For Reading Mid X Axis Fro Curve....
              .padding(.top)
              .frame(width: 70, height: 50)
              .offset(y: selected == value ? -15 : 0)
          })
      }
  }
  
  // Custom Shape....
  
  struct AnimatedShape: Shape {
      
      var centerX : CGFloat
      
      // animating Path....
      
      var animatableData: CGFloat{
          
          get{return centerX}
          set{centerX = newValue}
      }
      
      func path(in rect: CGRect) -> Path {
          
          return Path{path in
              
              path.move(to: CGPoint(x: 0, y: 15))
              path.addLine(to: CGPoint(x: 0, y: rect.height))
              path.addLine(to: CGPoint(x: rect.width, y: rect.height))
              path.addLine(to: CGPoint(x: rect.width, y: 15))
              
              // Curve....
              
              path.move(to: CGPoint(x: centerX - 35, y: 15))
              
              path.addQuadCurve(to: CGPoint(x: centerX + 35, y: 15), control: CGPoint(x: centerX, y: -30))
          }
      }
  }
