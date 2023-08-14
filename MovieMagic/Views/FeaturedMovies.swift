//
//  FeaturedMovies.swift
//  MovieMagic
//
//  Created by Nuwan Karunarathna on 2023-08-14.
//

import Foundation
import SwiftUI

struct FeaturedMovies: View {
    var body: some View {
        ZStack{
            VStack {
                Text("Featured List")
                TrendingList()
            }
        }
    }
}

struct FeaturedMovies_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedMovies()
    }
}
