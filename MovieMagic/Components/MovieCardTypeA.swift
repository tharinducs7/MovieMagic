//
//  MovieCardTypeA.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/6/23.
//

import SwiftUI


struct MovieCardTypeA: View {
    var movie: Movie
    @Namespace private var animation
    var showDetailView: Bool
    var selectedMovie: Movie?
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let rect = $0.frame(in: .named("LISTVIEW"))
            
            // Rotation animation based on scroll animation
            let minY = rect.minY
            
            HStack(spacing: -25) {
                // Movie Detail Card
                VStack(alignment: .leading, spacing: 6) {
                    Text(movie.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                    
                    Text("By \(movie.director)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    MovieRating(rating: 4)
                        .padding(.top, 10)
                    
                    Spacer(minLength: 10)
                    
                    HStack(spacing: 4) {
                        Text("\(movie.year)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                }
                .padding(20)
                .frame(width: size.width / 2, height: size.height * 0.8)
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.08), radius: 8, x:5, y: 5)
                        .shadow(color: .black.opacity(0.08), radius: 8, x:-5, y: -5)
                }
                .zIndex(1)

                // Movie Cover
                ZStack {
                    if !(showDetailView && selectedMovie?.id == movie.id) {
                        MoviePoster(posterURL: movie.poster)
                            .frame(width: (size.width / 2), height: size.height)
                            .matchedGeometryEffect(id: movie.id, in: animation)
                            .shadow(color: .black.opacity(0.1), radius: 5, x:5, y: 5)
                            .shadow(color: .black.opacity(0.1), radius: 5, x:-5, y: -5)
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                 
            }
            .frame(width: size.width)
            .rotation3DEffect(.init(degrees: convertOffsetToRotation(rect)), axis: (x: 1, y: 0, z: 0), anchor: .bottom, anchorZ: 1, perspective: 1)
        }
        .frame(height: 300)
    }
    
    func convertOffsetToRotation(_ rect: CGRect) -> CGFloat {
        let cardHeight = rect.height + 20
        let minY = rect.minY - 20
        let progress = minY < 0 ? (minY / cardHeight): 0
        let constrainedProgress = min(-progress, 1.0)
        return constrainedProgress * 90
    }
}

struct MovieCardTypeA_Previews: PreviewProvider {
    static var previews: some View {
       // MovieCardTypeA(movie: sampleMovies[0])
        
        SearchList()
    }
}
