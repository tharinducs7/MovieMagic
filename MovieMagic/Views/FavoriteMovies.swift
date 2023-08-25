//
//  FavoriteMovies.swift
//  MovieMagic
//
//  Created by Diliru on 2023-08-15.
//

import SwiftUI

struct FavoriteMovies: View {
  //  var movies: [Movie]
    @Namespace private var animation
    @StateObject private var movieVM = MoviesViewModel()
    @State private var showDetailView: Bool = false
    @State private var selectedMovie: Movie?
    @State private var animateCurrentMovie: Bool = false
    @State private var user: User? = DataManager.shared.getUser()
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Favorite")
                    .font(.largeTitle.bold())
                    .fontDesign(.rounded)
                
                Text("Movies")
                    .fontWeight(.semibold)
                    .padding(.leading, 15)
                    .foregroundColor(.gray)
                    .fontDesign(.rounded)
                    .offset(y: 2)
                
              
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
            
            GeometryReader {
                let size = $0.size
                
                ScrollView(.vertical, showsIndicators: false)  {
                    VStack(spacing: 35) {
                        ForEach(movieVM.favoriteMovies) { movie in
                                MovieCardTypeA(movie: movie, showDetailView: showDetailView, selectedMovie: movie)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            animateCurrentMovie = true
                                            selectedMovie = movie
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                                
                                                showDetailView = true
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 20)

                }
                .coordinateSpace(name: "LISTVIEW")
                .padding(.top, 15)
                .onAppear() {
                    if let userEmail = user?.email {
                        movieVM.fetchFavoritMoviesByUser(by: userEmail)
                    }
                    
                    print("Test eeee")

                }
                .refreshable {
                  movieVM.refreshData()
                }
            }
            
        }
        .overlay(content: {
            if let selectedMovie, showDetailView {
                MovieDetails(show:$showDetailView, animation: animation, movie: selectedMovie)
                .transition(.asymmetric(insertion: .identity, removal: .offset(y: 5)))
            }
        })
       
    }
    
    func bottomPadding(_ size: CGSize = .zero) -> CGFloat {
        let cardHeight: CGFloat = 300
        let scrollViewHeight: CGFloat = size.height
        
        return scrollViewHeight
    }
}

struct FavoriteMovies_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMovies()
    }
}


struct InfiniteStackView: View {
    @Binding var movies: [Movie]
    var movie: Movie
    
    var body: some View {
        VStack {
            MovieCardTypeB(movie: movie)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
