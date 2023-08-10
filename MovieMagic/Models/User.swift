//
//  User.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/6/23.
//

import SwiftUI

struct User: Identifiable, Codable {
    let id: UUID
    let name: String
    let email: String
    let favoriteGenres:[String]
}
