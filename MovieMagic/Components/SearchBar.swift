//
//  SearchBar.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/7/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @ObservedObject var movieVM: MoviesViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search", text: $searchText, onEditingChanged: { _ in
                          movieVM.searchMovies(by: searchText)
                      })
                .foregroundColor(.primary)
        }
        .padding(8)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .padding(.horizontal, 15)
    }
}


