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
case about = "about"
    
    var systemImage: String {
        switch self{
        case .home:
            return "house"
        case .list:
            return "popcorn"
        case .savedMovies:
            return "heart"
        case .about:
            return "info"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}

