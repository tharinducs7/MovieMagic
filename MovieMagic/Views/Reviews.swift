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
                ReviewComponent(review: MovieReview(id: 1, userName: "John Doe", email: "johndoe@example.com", rating: 4, review: "This is a great movie. I highly recommend it!", reviewTitle: "Nice Movie ❤️"))
                
                ReviewComponent(review: MovieReview(id: 2, userName: "John Doe", email: "johndoe@example.com", rating: 5, review: "Harry Potter and the Deathly Hallows, the final installment in J.K. Rowling's iconic series, is an absolute masterpiece that delivers a gripping conclusion to the magical journey that has captivated millions of readers worldwide. With heart-pounding action, emotional depth, and an awe-inspiring display of bravery, this book is a fitting end to an enchanting saga.", reviewTitle: "An Epic Finale: Harry Potter and the Deathly Hallows 🪄"))
                
                ReviewComponent(review: MovieReview(id: 3, userName: "John Doe", email: "johndoe@example.com", rating: 4, review: "As the final installment in the iconic Harry Potter series, 'Harry Potter and the Deathly Hallows' provides an emotional, thrilling, and satisfying conclusion to the epic tale of the boy who lived. J.K. Rowling has outdone herself once again, delivering a breathtaking masterpiece that captivates readers from start to finish.", reviewTitle: "A Magical Culmination"))

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
