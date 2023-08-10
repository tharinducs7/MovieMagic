//
//  MoviePoster.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/6/23.
//

import SwiftUI

struct MoviePoster: View {
    var posterURL: String
    
    var body: some View {
        GeometryReader { geometry in
            if let url = URL(string: posterURL) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        // Show a placeholder or error image if the URL is invalid
                        Color.red // Replace with your custom placeholder/error image
                    }
        }
    }
}

struct MoviePoster_Previews: PreviewProvider {
    static var previews: some View {
        let posterURL = "https://m.media-amazon.com/images/M/MV5BMGVmMWNiMDktYjQ0Mi00MWIxLTk0N2UtN2ZlYTdkN2IzNDNlXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_SX300.jpg"
        MoviePoster(posterURL: posterURL)
            .frame(width: 200, height: 300)
    }
}
