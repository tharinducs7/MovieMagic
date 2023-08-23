//
//  Constants.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/7/23.
//

import Foundation

struct MovieConstants {
    static let moviesURL = URL(string: "https://cvtub8qk88.execute-api.ap-south-1.amazonaws.com/dev/movie")!
    static let trendingMoviesURL = URL(string: "https://cvtub8qk88.execute-api.ap-south-1.amazonaws.com/dev/movie/trending")!
    static let genresURL = URL(string: "https://cvtub8qk88.execute-api.ap-south-1.amazonaws.com/dev/genre")!
    static let theatersURL = URL(string: "https://raw.githubusercontent.com/tharinducs7/movie-list-json/main/theaters.json")!
    static let reviewsURL = URL(string: "https://cvtub8qk88.execute-api.ap-south-1.amazonaws.com/dev/review")!
}
