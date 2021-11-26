//
//  Home.swift
//  UI-340 (iOS)
//
//  Created by nyannyan0328 on 2021/10/25.
//

import SwiftUI

struct Home: View {
    @State var currentTab = ""
    @State var onTapCurrent : String = ""
    @Environment(\.colorScheme) var scheme
    @Namespace var animation
    var body: some View {
        VStack(spacing:0){
            
            VStack{
                
                
                HStack(spacing:15){
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                        
                    Text("McDonalds - ChainaTown")
                            .font(.title3.bold())
                        
                            
                    }
                    
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title3)
                        
                    

                    }
                    
                }
                .padding(.horizontal)
                .foregroundColor(.primary)
                
                
                
                ScrollViewReader{proxy in
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        
                            
                        HStack(spacing:30){
                                
                                
                                ForEach(tabItems){tab in
                                    
                                    
                                    VStack{
                                        Text(tab.tab)
                                          
                                            .foregroundColor(currentTab.replacingOccurrences(of: " SCROLL", with: "") == tab.id ? .black : .gray)
                                          
                                        
                                        
                                        if currentTab.replacingOccurrences(of: " SCROLL", with: "") == tab.id{
                                            
                                            
                                            Capsule()
                                                .fill(.black)
                                                .frame(height: 3)
                                                .matchedGeometryEffect(id: "TAB", in: animation)
                                                .padding(.horizontal,-10)
                                        }
                                        
                                        else{
                                            
                                            Capsule()
                                                .fill(.clear)
                                                .frame(height: 3)
                                                .padding(.horizontal,-10)
                                            
                                        }
                                    }
                                    .onTapGesture {
                                        
                                        if "\(tab.id) SCROLL" == currentTab{
                                            
                                            return
                                        }
                                        
                                        
                                        withAnimation(.easeInOut){
                                            
                                            
                                        onTapCurrent = tab.id
                                            proxy.scrollTo(tab.id, anchor: .topTrailing)
                                            
                                        }
                                        
                                        
                                        
                                        
                                        
                                    }
                                  
                                     
                                    
                                    
                                }
                                
                                
                            }
                        .padding(.horizontal)
                           
                            
                            
                    
                        
                        
                    }
                    .onChange(of: currentTab) { newValue in
                        
                        
                        withAnimation{
                            
                            proxy.scrollTo(currentTab, anchor: .topTrailing)
                        }
                    }
                    
                    
                }
                .padding(.top)
                
                
                
            }
            .padding([.top])
            .background(scheme == .dark ? Color.black : Color.white)
            .overlay(
            
            Divider()
                .padding(.horizontal,-15)
            
            ,alignment: .bottom
            
            )
            
            
            ScrollView(.vertical, showsIndicators: false) {
                
                
                ScrollViewReader{proxy in
                    
                    VStack(spacing:15){
                        
                        
                        ForEach(tabItems){tab in
                            
                            MenuCardView(tab: tab, currentTab: $currentTab)
                            
                        }
                    }
                    .padding([.horizontal,.top])
                    .onChange(of: onTapCurrent) { nv in
                        
                        withAnimation(.easeInOut){
                            
                            proxy.scrollTo(onTapCurrent, anchor: .topTrailing)
                       
                        }
                        
                    }
                    
                    
                }
                
                
                
                
                
            }
            .coordinateSpace(name: "SCROLL")
            
            
        }
        .onAppear {
            
            currentTab = tabItems.first?.id ?? ""
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct MenuCardView : View{
    
    var tab : Tab
    
    @Binding var currentTab : String
    
    var body: some View{
        
        VStack(alignment:.leading,spacing: 10){
            
            Text(tab.tab)
                .font(.title.bold())
                .padding(.vertical)
            
          
            
            ForEach(tab.foods){food in
                
                
                HStack(spacing:15){
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        
                        Text(food.title)
                            .font(.title2.bold())
                        
                        Text(food.description)
                            .font(.footnote.weight(.semibold))
                            .foregroundColor(.gray)
                        
                        
                        Text("Price : \(food.price)")
                            .font(.footnote.bold())
                        
                        
                        
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    
                    
                    Image(food.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 75, height: 75)
                        .cornerRadius(10)
                    
                }
                Divider()
                    .background(.red)
            }
            
            
            
        
            
            
            
            
        }
      
            .modifier(OffsetModifier(tab: tab, currentTab: $currentTab))
            .tag(tab.id)
        
    }
}
