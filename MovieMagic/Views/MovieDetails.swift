//
//  MovieDetails.swift
//  MovieMagic
//
//  Created by Diliru on 2023-08-15.
//

import SwiftUI

struct MovieDetails: View {
    @Binding var show: Bool
    
    var animation: Namespace.ID
    var movie: Movie
    
    @State private var animationContent: Bool = false
    @State private var offsetAimation: Bool = false
    @State private var isReviewSheetPresented = false
    @State private var isViewReviewsSheetPresented = false
    @StateObject private var movieVM = MoviesViewModel()
    @State private var user: User? = DataManager.shared.getUser()
    @State private var favToggle: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    offsetAimation = false
                }
                withAnimation(.easeInOut(duration: 0.3).delay(0.1)) {
                    //animationContent = false
                    show = false
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .contentShape(Rectangle())
            }
            .padding([.leading, .vertical], 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(animationContent ? 1 : 0)
            
            // Movie Preview
            GeometryReader {
                let size = $0.size
                
                HStack(spacing: 20) {
                    MoviePoster(posterURL: movie.poster)
                        .frame(width: size.width / 2, height: size.height)
                        .clipShape(CustomCorners(corners: [.topRight, .bottomRight], radius: 20))
                        .matchedGeometryEffect(id: movie.id, in: animation)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.title)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .fontDesign(.rounded)
                        
                        Text("By \(movie.director)")
                            .font(.callout)
                            .foregroundColor(.gray)
                        
                        if let reviewAverage = movie.reviewAverage {
                            let roundedRating = Int(reviewAverage.rounded())
                            MovieRating(rating: roundedRating)
                        }
                        
                    }
                    .padding(.trailing, 15)
                    .padding(.top, 30)
                    .offset(y: offsetAimation ? 0: 100)
                    .opacity(offsetAimation ? 1: 0)
                }
            }
            .frame(height: 300)
            .zIndex(1)
            
            Rectangle()
                .fill(.gray.opacity(0.04))
                .ignoresSafeArea()
                .overlay(alignment: .top, content: {
                    MovieInfo()
                })
                .padding(.leading, 30)
                .padding(.top, -180)
                .zIndex(0)
                .opacity(animationContent ? 1 : 0)
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background {
                Rectangle()
                    .fill(.white)
                    .ignoresSafeArea()
                    .opacity(animationContent ? 1 : 0)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 0.35)) {
                    animationContent = true
                }
                
                withAnimation(.easeInOut(duration: 0.35).delay(0.1)) {
                    offsetAimation = true
                }
                
                movieVM.fetchMovieByID(by: movie.id)
            }
    }
    
    @ViewBuilder
    func MovieInfo() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button {
                    updateFavToggle()
                    isViewReviewsSheetPresented = true
                  
                } label: {
                    Label("Reviews", systemImage:"text.alignleft")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                .sheet(isPresented: $isViewReviewsSheetPresented, content: {
                    if let movieById = movieVM.movieById {
                           Reviews(movie: movieById)
                    }
                })
                .frame(maxWidth: .infinity)
                
                Button {
                    updateFavToggle()
                    
                    if let userEmail = user?.email {
                        if(!favToggle) {
                            movieVM.addFavoriteMovies(movieId: movie.id, email: userEmail)
                            
                        } else {
                            movieVM.removeFavoriteMovies(movieId: movie.id, email: userEmail)
                        }
                    }
                } label: {
                    Image(systemName: "heart.fill")
                        .foregroundColor(checkIfEmailExists() ? .red : .gray)
                    Label("Favorite", systemImage: "suit.heart")
                        .font(.callout)
                        .labelStyle(.titleOnly)
                        .foregroundColor(.gray)
                   
                }
                .frame(maxWidth: .infinity)
                
                Button {
                    isReviewSheetPresented = true
                } label: {
                    Label("Add Review", systemImage:"text.badge.plus")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.trailing, 10)
            .padding(.leading, -20)
            
            Divider()
                .padding(.top, 25)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    Text("Movie Plot")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(movie.plot)
                        .font(.callout)
                        .foregroundColor(.gray)
                    
                    Text("Movie Genre")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(movie.genre)
                        .font(.callout)
                        .foregroundColor(.gray)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Director")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(movie.director)
                        .font(.callout)
                        .foregroundColor(.gray)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Writer")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(movie.writer ?? "Unknown Writer")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Actors")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(movie.actors ?? "Unknown Actors")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding(.bottom, 15)
                .padding(.top, 20)
            }
            
        }
        .sheet(isPresented: $isReviewSheetPresented, content: {
            AddReview(isPresented: $isReviewSheetPresented, movie: movie)
               
        })
        .padding(.top, 180)
        .padding([.horizontal, .top], 15)
        .offset(y: offsetAimation ? 0: 100)
        .opacity(offsetAimation ? 1: 0)
    }
    
    func checkIfEmailExists() -> Bool {
        let userEmail = user?.email ?? ""
        let favoriteMovies = movieVM.movieById?.favorites ?? []
        movieVM.fetchMovieByID(by: movie.id)
        return favoriteMovies.contains(userEmail)
    }
    
    func updateFavToggle() {
        self.favToggle = checkIfEmailExists()
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
