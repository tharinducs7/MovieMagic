//
//  SearchList.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/5/23.
//

import SwiftUI

struct SearchList: View {
    @Namespace private var animation
    
    @State private var showDetailView: Bool = false
    @State private var selectedMovie: Movie?
    @State private var animateCurrentMovie: Bool = false
    
    @StateObject private var movieVM = MoviesViewModel()
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                HStack {
                    Text("Browse")
                        .font(.largeTitle.bold())
                        .fontDesign(.rounded)
                        .foregroundColor(.black)
                    
                    Text("Movies")
                        .fontWeight(.semibold)
                        .padding(.leading, 15)
                        .foregroundColor(.gray)
                        .fontDesign(.rounded)
                        .offset(y: 2)
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                
                
                SearchBar(searchText: $searchText, movieVM: movieVM)
                
                if(searchText.isEmpty) {
                    GenreTag(movies: movieVM.movies, activeTag: $movieVM.selectedGenre, movieVM: movieVM)
                }
                
                GeometryReader {
                    let size = $0.size
                    
                    ScrollView(.vertical, showsIndicators: false)  {
                        VStack(spacing: 35){
                            ForEach(movieVM.movies, id: \.title) { movie in
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
                }
            }
            
            .overlay(content: {
                if let selectedMovie, showDetailView {
                    MovieDetails(show:$showDetailView, animation: animation, movie: selectedMovie)
                    // for more fluent animation
                        .transition(.asymmetric(insertion: .identity, removal: .offset(y: 5)))
                }
                
            })
        }
    }
    
    func bottomPadding(_ size: CGSize = .zero) -> CGFloat {
        let cardHeight: CGFloat = 300
        let scrollViewHeight: CGFloat = size.height
        
        return scrollViewHeight
    }
}

struct SearchList_Previews: PreviewProvider {
    static var previews: some View {
        SearchList()
    }
}
