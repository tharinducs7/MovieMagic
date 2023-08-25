//
//  Home.swift
//  MovieMagic
//
//  Created by Nuwan Karunarathna on 2023-08-14.
//

import Foundation
import SwiftUI

struct Home: View {
    @State private var user: User? = DataManager.shared.getUser()
   
    var body: some View {
        ZStack{
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Hello 👋")
                            .font(.system(size: 12))
                            .fontDesign(.rounded)
                            
                        if let userName = user?.name {
                            Text(userName)
                                .font(.title)
                                .fontDesign(.rounded)
                                .fontWeight(.bold)
                        } else {
                            Text("No user name")
                                .font(.title)
                                .fontWeight(.bold)
                            
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Handle button action here to see user info
                    }) {
                        Image(systemName: "info.circle")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                ScrollView {
                    TrendingList()
                        
                    
                    FavoriteList()
                    
                    RecomendedList()
                }
               
                    
            }
        }
    }
}



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
