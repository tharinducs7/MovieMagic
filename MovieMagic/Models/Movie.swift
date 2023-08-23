//
//  Movie.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/5/23.
//

import SwiftUI

struct Movie: Identifiable, Codable {
    var id: Int
    var title: String
    var year: Int
    var released: String?
    var runtime: Int
    var genre: String
    var director: String
    var writer: String?
    var actors: String?
    var plot: String
    var language: String?
    var country: String?
    var poster: String
    var reviews: [MovieReview]?
    var trendingScore: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case year
        case released
        case runtime
        case genre
        case director
        case writer
        case actors
        case plot
        case language
        case country
        case poster
        case reviews
        case trendingScore
    }
}

let sampleMovies: [Movie] = [
    Movie(id: 1, title: "Harry Potter and the Deathly Hallows: Part 2", year: 2011, released: "15 Jul 2011", runtime: 130, genre: "Adventure, Family, Fantasy", director: "David Yates", writer: "Steve Kloves, J.K. Rowling", actors: "Daniel Radcliffe, Emma Watson, Rupert Grint", plot: "Harry, Ron, and Hermione search for Voldemort's remaining Horcruxes in their effort to destroy the Dark Lord as the final battle rages on at Hogwarts.", language: "English, Latin", country: "United Kingdom, United States", poster:  "https://m.media-amazon.com/images/M/MV5BMGVmMWNiMDktYjQ0Mi00MWIxLTk0N2UtN2ZlYTdkN2IzNDNlXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_SX300.jpg"),
    Movie(id: 2, title: "Harry Potter and the Deathly Hallows: Part 1", year: 2010, released: "19 Nov 2010", runtime: 146, genre: "Adventure, Family, Fantasy", director: "David Yates", writer: "Steve Kloves, J.K. Rowling", actors: "Daniel Radcliffe, Emma Watson, Rupert Grint", plot: "As Harry, Ron and Hermione race against time and evil to destroy the Horcruxes, they uncover the existence of the three most powerful objects in the wizarding world: the Deathly Hallows.", language: "English, Latin", country: "United Kingdom, United States", poster: "https://m.media-amazon.com/images/M/MV5BMTQ2OTE1Mjk0N15BMl5BanBnXkFtZTcwODE3MDAwNA@@._V1_SX300.jpg"),
    Movie(id: 3, title: "Fast X", year: 2023, released: "19 May 2023", runtime: 141, genre: "Action, Adventure, Crime", director: "Louis Leterrier", writer: "Dan Mazeau, Justin Lin, Zach Dean", actors: "Vin Diesel, Michelle Rodriguez, Jason Statham", plot: "Dom Toretto and his family are targeted by the vengeful son of drug kingpin Hernan Reyes.", language: "English", country: "United States, China", poster:  "https://m.media-amazon.com/images/M/MV5BNzZmOTU1ZTEtYzVhNi00NzQxLWI5ZjAtNWNhNjEwY2E3YmZjXkEyXkFqcGdeQXVyODk4OTc3MTY@._V1_SX300.jpg"),
    Movie(id: 4, title: "Guardians of the Galaxy", year: 2014, released: "01 Aug 2014", runtime: 121, genre: "Action, Adventure, Comedy", director: "James Gunn", writer: "James Gunn, Nicole Perlman, Dan Abnett", actors: "Chris Pratt, Vin Diesel, Bradley Cooper", plot: "A group of intergalactic criminals must pull together to stop a fanatical warrior with plans to purge the universe.", language: "English", country: "United States", poster:  "https://m.media-amazon.com/images/M/MV5BNDIzMTk4NDYtMjg5OS00ZGI0LWJhZDYtMzdmZGY1YWU5ZGNkXkEyXkFqcGdeQXVyMTI5NzUyMTIz._V1_SX300.jpg"),
    Movie(id: 5, title: "Iron Man", year: 2008, released: "02 May 2008", runtime: 126, genre: "Action, Adventure, Sci-Fi", director: "Jon Favreau", writer: "Mark Fergus, Hawk Ostby, Art Marcum", actors: "Robert Downey Jr., Gwyneth Paltrow, Terrence Howard", plot: "After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil.", language: "English, Persian, Urdu, Arabic, Kurdish, Hindi, Hungarian", country: "United States, Canada", poster:  "https://m.media-amazon.com/images/M/MV5BMTczNTI2ODUwOF5BMl5BanBnXkFtZTcwMTU0NTIzMw@@._V1_SX300.jpg"),
]
