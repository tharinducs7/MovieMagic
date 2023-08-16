//
//  Reviews.swift
//  MovieMagic
//
//  Created by Nuwan Karunarathna on 2023-08-14.
//

import SwiftUI

struct Reviews: View {
    var movie: Movie
    
    var body: some View {
        VStack(spacing: 15) {
            
            // Movie Preview
            GeometryReader {
                let size = $0.size
                
                HStack(spacing: 20) {
                    MovieHeader(movie: movie)
                        .padding(20)
                }
            }
            .frame(height: 100)
            .zIndex(1)
            
            List {
                if let reviews = movie.reviews {
                    ForEach(reviews, id: \.id) { review in
                        ReviewComponent(review: review)
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

struct Reviews_Previews: PreviewProvider {
    static var previews: some View {
        Reviews(movie: sampleMovies[0])
    }
}
