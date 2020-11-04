//
//  CategoriesView.swift
//  WhatsCooking
//
//  Created by Sajid Javed on 26/10/2020.
//



import Foundation
import SwiftUI
import KingfisherSwiftUI

//Will contain only one model of data, shown as lists
struct ExploreView: View{
    
    @State var data: [Explore] = [] //horizantal main items data
    
    @State var navigationTitle:String = "Explore"
    @State var tagToggle:String = Tags.cuisines.rawValue
    @State private var didTapCuisines:Bool = true
    @State private var gotToExploreExtendedView: Bool = false
    @State private var tappedItemTitle: String = ""
    @ObservedObject var mainViewModel = MainViewModel.shared
    
    
    var body: some View{
        
        NavigationView{
            
            GeometryReader{ geometry in
                
                
                VStack(alignment: .leading, spacing: 0){
                    
                    
                    HStack{//Tag Buttons Stack
                        
                        Button(action: {
                            navigationTitle = Tags.cuisines.rawValue
                            loadCuisines()
                            
                        }) {
                            HStack(alignment: .center){
                                Image(systemName: "circle.grid.cross.down.fill").foregroundColor(didTapCuisines ? Color.white : Color(.systemGray3))
                                    .padding(2)
                                
                                Text(Tags.cuisines.rawValue)
                                    .font(.system(size: 16, weight: .heavy, design:.default))
                                    .foregroundColor(didTapCuisines ? Color.white : Color(.systemGray3))
                            }                    .frame(maxWidth: .infinity)
                            
                            
                        }//Button
                        
                        .padding(13)
                        .background(didTapCuisines  ? Color(.systemRed) : Color.white)
                        .cornerRadius(23)
                        
                        
                        
                        
                        Button(action: {
                            loadGenres()
                        }) {
                            HStack(alignment: .center){
                                Image(systemName: "slider.vertical.3").foregroundColor(didTapCuisines ? Color(.systemGray3) : Color(.white))
                                    .padding(2)
                                Text(Tags.genres.rawValue)
                                    .font(.system(size: 16, weight: .heavy, design:.default))
                                    .foregroundColor(didTapCuisines ? Color(.systemGray3) : Color(.white))
                            } .frame(maxWidth: .infinity)
                            
                        }//button config
                        .padding(13)
                        .background(didTapCuisines ? Color.white : Color(.systemRed))
                        .cornerRadius(23)
                        .frame(maxWidth: 180)
                        
                    }//HStack (Buttons)
                    .padding()
                    .padding(.top, 7)
                    .padding(.bottom, -18)
                    
                    
                    ScrollView(.horizontal, showsIndicators: true){
                        
                        
                        
                        //horizantal items here
                        NavigationLink(destination: ExploreExtendedView(parameter: tappedItemTitle,
                                                                        type: didTapCuisines ? Tags.cuisines.rawValue : Tags.genres.rawValue), isActive: self.$gotToExploreExtendedView) { EmptyView() }
                        
                        HStack{
                            
                            
                            ForEach(data, id: \.id) { item in
                                
                                
                                RowItem(item: item, didTapCuisines: self.$didTapCuisines)
                                    
                                    .onTapGesture{
                                        
                                        tappedItemTitle = item.type
                                        self.gotToExploreExtendedView.toggle()
                                    }
                                
                            }
                            
                            
                        }//HStack
                        .onAppear{
                            if didTapCuisines {
                                loadCuisines()
                                
                            }else{
                                loadGenres()
                                
                            }
                        }
                        .padding()
                        .foregroundColor(Color.white)
                        .cornerRadius(25)
                        .lineLimit(1)
                        
                        
                        
                        
                        
                        
                    }//ScrollView
                    .navigationBarTitle(navigationTitle, displayMode: .inline)
                    
                    
                }//Parent VStack
                .frame(width: geometry.size.width)
                
                
                
            }//GeometryReader
            
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    
    //Title inside image Overlay
    struct ImageOverlay: View {
        var title: String
        var body: some View {
            VStack {
                Text("\(title)")
                    .font(.system(size: 16))
                    .font(.callout).bold()
                    .frame(width: 76, height: 18)
                    .padding(7)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .opacity(0.8)
                    .cornerRadius(10)
                    .padding(.horizontal, 12)
                
                HStack(spacing: 2, content: {
                    
                    ForEach(0..<5){i in
                        
                        Image(systemName: "star.fill").resizable().frame(width: 15, height: 15).foregroundColor(.yellow)
                        
                    }
                }
                
                )
                .padding([.top, .bottom], -5)
                .padding(.bottom, 20)
            }
            
        }
    }
    
    //Main Cuisine Item
    struct RowItem: View {
        
        var item: Explore
        @Binding var didTapCuisines: Bool
        
        var body: some View{
            
            LazyVStack(spacing: 0){
                //image with title inside
                if let imageUrl = item.image  {
                    if let url = URL(string: imageUrl){
                        
                        KFImage(url, options: [.transition(.fade(0.2))])
                            .resizable()
                            .cancelOnDisappear(true)
                            
                            .placeholder{
                                Image("meal_1")
                            }
                            .aspectRatio(contentMode: self.didTapCuisines ? .fill : .fit)
                            .frame(width: 250, height: 450)
                            .scaledToFit()
                            .cornerRadius(12)
                            
                            .shadow(color: Color.gray,
                                    radius: 3.0,
                                    x: CGFloat(10),
                                    y: CGFloat(10))
                            
                            .overlay(ImageOverlay(title: item.type), alignment: .bottomLeading)
                        
                        
                        
                        
                    }
                }
                //description below
                Text("\(item.description)")
                    .padding(.top, 10)
                    .padding(.leading, 4)
                    .foregroundColor(Color(.systemGray4))
                    .lineLimit(6)
                    .fixedSize(horizontal: false, vertical: true)
                
            }
            .padding(8)
            
            
            
            
        }
    }
    
    private func loadCuisines(){
        self.didTapCuisines = true
        let tag = Tags.cuisines.rawValue
        tagToggle = tag
        self.data = ExploreEntityMapper.shared.mapExploreToCuisines(areas: self.mainViewModel.getAllAreas())
    }
    
    private func loadGenres(){
        self.didTapCuisines = false
        //load cousines
        let tag = Tags.genres.rawValue
        navigationTitle = tag
        tagToggle = tag
        
        self.data = ExploreEntityMapper.shared.mapExploreToMealTypes(mealTypes: self.mainViewModel.getAllMealCategories())
    }
    
    
    
    
    
    struct ExploreView_Previews: PreviewProvider {
        static var previews: some View {
            
            ExploreView()
            
        }
    }
    
    
    
    
    
    
    //Not Used
    struct SearchBar: View {
        
        @Binding var searchText: String
        @Binding var isSearching: Bool
        
        
        
        
        var body: some View {
            HStack {
                HStack {
                    TextField("Search terms here", text: $searchText)
                        .padding(.leading, 24)
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(6)
                .padding(.horizontal)
                .onTapGesture(perform: {
                    isSearching = true
                })
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Spacer()
                        
                        if isSearching {
                            Button(action: { searchText = "" }, label: {
                                Image(systemName: "xmark.circle.fill")
                                    .padding(.vertical)
                            })
                            
                        }
                        
                    }.padding(.horizontal, 32)
                    .foregroundColor(.gray)
                ).transition(.move(edge: .trailing))
                .animation(.spring())
                
                if isSearching {
                    Button(action: {
                        isSearching = false
                        searchText = ""
                        
                        
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        
                    }, label: {
                        Text("Enter")
                            .padding(.trailing)
                            .padding(.leading, 0)
                    })
                    .transition(.move(edge: .trailing))
                    .animation(.spring())
                }
                
            }
        }
    }
    
    
    
    
}
