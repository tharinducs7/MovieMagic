//
//  GenreSelection.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/23/23.
//

import SwiftUI

struct GenreSelection: View {
    let genre: Genre
    @Binding var selectedGenres: Set<String>
    @Namespace private var animation
    
    var body: some View {
        Button(action: {
            if selectedGenres.contains(genre.key) {
                selectedGenres.remove(genre.key)
            } else {
                selectedGenres.insert(genre.key)
            }
        }) {
            Text(genre.genre)
                .foregroundColor(selectedGenres.contains(genre.key) ? .white : .purple)
                .padding()
                .background {
                    if selectedGenres.contains(genre.key) {
                        Capsule()
                            .fill(Color("Purple Dark"))
                            .matchedGeometryEffect(id: "ACTIVETAG", in: animation)
                    } else {
                        Capsule()
                            .fill(Color("Gold Light").opacity(0.2))
                    }
                }
                .cornerRadius(16)
        }
    }
}

