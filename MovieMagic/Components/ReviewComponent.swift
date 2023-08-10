//
//  ReviewComponent.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/6/23.
//

import SwiftUI

struct ReviewComponent: View {
    let review: MovieReview
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(review.reviewTitle)
                .font(.title2)
                .fontDesign(.rounded)
            HStack(spacing: 10) {
                MovieRating(rating: review.rating)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(review.userName)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .fontDesign(.rounded)
                }
            }

            Text(review.review)
                .font(.footnote)
        }
        .padding(20)
    }
    
    private func hideEmail(_ email: String) -> String {
        let components = email.components(separatedBy: "@")
        guard let name = components.first else { return email }
        let hiddenEmail = String(repeating: "*", count: min(name.count - 2, name.count)) + "@" + components.last!
        return hiddenEmail
    }
}

struct ReviewComponent_Previews: PreviewProvider {
    static var previews: some View {
        ReviewComponent(review: MovieReview(id: 1, userName: "John Doe", email: "johndoe@example.com", rating: 4, review: "This is a great movie. I highly recommend it!", reviewTitle: "Nice Movie"))
    }
}
