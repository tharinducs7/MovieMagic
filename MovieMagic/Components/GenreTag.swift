//
//  GenreTag.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/5/23.
//

import SwiftUI

struct GenreTag: View {
    var movies: [Movie]
    @Binding var activeTag: String
    @Namespace private var animation
    @ObservedObject var movieVM: MoviesViewModel
    @StateObject private var genreVM = GenreViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {

                ForEach(genreVM.genres, id: \.id) { genre in
                    Text(genre.genre)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .foregroundColor(activeTag == genre.key ? .white : .black)
                        .background{
                            if activeTag == genre.key {
                                Capsule()
                                    .fill(Color("Purple Dark"))
                                    .matchedGeometryEffect(id: "ACTIVETAG", in: animation)
                            } else {
                                Capsule()
                                    .fill(Color("Gold Light").opacity(0.2))
                            }
                        }
                        .cornerRadius(16)
                        // Changing the active tag
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)) {
                                activeTag = genre.key
                            }
                            
                            movieVM.selectedGenre = genre.key
                            movieVM.filterMovies(by: genre.key)
                        }
                }
            }
            .padding()
        }
    }
}

