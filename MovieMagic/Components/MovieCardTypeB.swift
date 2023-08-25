//
//  MovieCardTypeB.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/7/23.
//

import SwiftUI

struct MovieCardTypeB: View {
    var movie: Movie
    @Namespace private var animation
    @State private var isSheetPresented = false
//    var selectedMovie: Movie?
    
    var body: some View {
        VStack(spacing: 0.0){
            VStack(spacing: 4.0){
           
            }
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
            .frame(width: 150, height: 125, alignment: .top)
            .foregroundColor(.white)
            .background(MoviePoster(posterURL:movie.poster))
            .mask(MoviePoster(posterURL:movie.poster))
            .overlay{
                RoundedRectangle(cornerRadius: 40)
                    .stroke(LinearGradient(colors: [Color.cyan, Color.cyan.opacity(0), Color.cyan.opacity(0)], startPoint: .top, endPoint: .bottom))
            }
            
        }
        .frame(height: 350)
        .font(.footnote)
        .shadow(radius: 10)
        .sheet(isPresented: $isSheetPresented) {
           
                MovieDetails(show: $isSheetPresented, animation: animation, movie: movie)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: 5)))
            
        }
        .onTapGesture {
                   isSheetPresented.toggle()
        }
        
    }
}

struct MovieCardTypeB_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardTypeB(movie: sampleMovies[0])
    }
}
