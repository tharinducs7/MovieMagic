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
                if let userName = user?.name {
                    Text(userName)
                } else {
                    Text("No user name")
                }
                
                Text("Trending List")
                TrendingList()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
