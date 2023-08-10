//
//  TrendingList.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/7/23.
//

import SwiftUI

struct TrendingList: View {
    
    @State private var selectedMovie: Movie?
    @StateObject private var movieVM = MoviesViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(movieVM.movies) { movie in
                    GeometryReader { geometry in
                        MovieCardTypeB(movie: movie)
                            .rotation3DEffect(
                                Angle(degrees: (Double(geometry.frame(in: .global).minX) - 20) / -5),
                                axis: (x: 0, y: 10.0, z: 0))
                    }.frame(width: 140, height: 150)
                    
                }
            }
            .padding(10)
            
            Spacer()
        }
    }
    
}

struct TrendingList_Previews: PreviewProvider {
    static var previews: some View {
        TrendingList()
    }
}
