//
//  FeaturedMovies.swift
//  MovieMagic
//
//  Created by Nuwan Karunarathna on 2023-08-14.
//

import Foundation
import SwiftUI

struct FeaturedMovies: View {
    @StateObject private var movieVM = MoviesViewModel()

    var body: some View {
           GeometryReader { geometry in
               ScrollView {
                   VStack {
                       Text("Featured List")
                           .font(.title3)
                           .fontWeight(.semibold)
                           .frame(maxWidth: .infinity, alignment: .leading)
                           .padding([.leading, .top], 20)
                           
                       TrendingList()
                       
                   }
                   .frame(width: geometry.size.width, height: geometry.size.height)
               }
               .refreshable {
                 movieVM.refreshData()
               }
           }
       }
}

struct FeaturedMovies_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedMovies()
    }
}
