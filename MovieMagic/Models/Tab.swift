//
//  Tab.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/6/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
case home = "Home"
case list = "List"
case savedMovies = "Liked"
case about = "Theaters"
    
    var systemImage: String {
        switch self{
        case .home:
            return "house"
        case .list:
            return "list.and.film"
        case .savedMovies:
            return "heart"
        case .about:
            return "popcorn.fill"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}

