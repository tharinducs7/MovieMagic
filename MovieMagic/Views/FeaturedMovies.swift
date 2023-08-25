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
    @State private var user: User? = DataManager.shared.getUser()
    var body: some View {
           GeometryReader { geometry in
               ScrollView {
                   VStack {
                       FavoriteList()
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
