//
//  Home.swift
//  MovieMagic
//
//  Created by Nuwan Karunarathna on 2023-08-14.
//

import Foundation
import SwiftUI

struct Home: View {
    var body: some View {
        ZStack{
            VStack {
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
