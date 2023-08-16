//
//  MoviewReview.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/6/23.
//

import SwiftUI

struct MovieReview: Identifiable, Codable {
    let id: Int
    let movieId: Int
    let userName: String
    let email: String
    let rating: Int
    let review: String
    let reviewTitle: String
    
    enum CodingKeys: String, CodingKey {
           case id
           case movieId
           case userName
           case email
           case rating
           case review
           case reviewTitle
       }
}

