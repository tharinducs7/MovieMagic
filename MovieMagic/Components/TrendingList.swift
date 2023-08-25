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
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Trending Movies")
                        .font(.headline)
                        .fontDesign(.rounded)

                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, -40)
            .padding(.top, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 50) {
                    ForEach(movieVM.trendingMovies) { movie in
                        GeometryReader { geometry in
                            
                            let x = geometry.frame(in: .global).minX
                            let scale = getScale(proxy: geometry)
                            
                            MovieCardTypeB(movie: movie)
                                .clipped()
                                .scaleEffect(CGSize(width: scale, height: scale))
                        }
                        .frame(width: 130, height: 300)
                    }
                }
                .padding(10)
                .padding(.top, -80)
                .padding(.bottom, 50)
                
                Spacer()
            }
            
        }
    }
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        
        let x = proxy.frame(in: .global).minX
        let diff = abs(x)
        
        if diff < 100 {
            scale = 1 + diff / 500
        }
        return scale
    }
    
    
}

struct TrendingList_Previews: PreviewProvider {
    static var previews: some View {
        TrendingList()
    }
}
