//
//  MovieHeader.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/6/23.
//

import SwiftUI

struct MovieHeader: View {
    var movie: Movie
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            HStack(spacing: 20) {
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
                .padding(.leading, 15)
                
                MoviePoster(posterURL: movie.poster)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width / 4, height: size.height)
                    .clipShape(CustomCorners(corners: [.topRight, .bottomRight], radius: 280))
                   // .padding(.top, -60)
            }
        }
        .frame(height: 100)
        .zIndex(1)
    }
}

struct MovieHeader_Previews: PreviewProvider {
    static var previews: some View {
        MovieHeader(movie: sampleMovies[0])
       // AddReview(movie: sampleMovies[0])
    }
}
