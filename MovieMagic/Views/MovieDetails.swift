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
                        
                        MovieRating(rating: 5)
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
            }
    }
    
    @ViewBuilder
    func MovieInfo() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button {
                    isViewReviewsSheetPresented = true
                } label: {
                    Label("Reviews", systemImage:"text.alignleft")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                .sheet(isPresented: $isViewReviewsSheetPresented, content: {
                    Reviews(movie: movie)
                })
                .frame(maxWidth: .infinity)
                
                Button {
                    
                } label: {
                    Label("Favorite", systemImage:"suit.heart")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                
                Button {
                    
                } label: {
                    Label("Share", systemImage:"square.and.arrow.up")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
            }
            
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
                }
                .padding(.bottom, 15)
                .padding(.top, 20)
            }
            
            Button {
                isReviewSheetPresented = true
            } label: {
                Text("Add Review")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 10)
                    .background {
                        Capsule()
                            .fill(Color("Purple Dark"))
                    }
                    .foregroundColor(Color("Gold Light"))
                    .fontDesign(.rounded)
            }
            .padding(.bottom, 15)
            .sheet(isPresented: $isReviewSheetPresented, content: {
                AddReview(movie: movie)
            })
        }
        .padding(.top, 180)
        .padding([.horizontal, .top], 15)
        .offset(y: offsetAimation ? 0: 100)
        .opacity(offsetAimation ? 1: 0)
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
