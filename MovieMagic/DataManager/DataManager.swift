//
//  DataManager.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/6/23.
//

import Foundation

final class DataManager {
    static let shared = DataManager()

    private let userDefaults = UserDefaults.standard
    private let moviesKey = "movies"
    private let genresKey = "genres"

    // MARK: - Movies
    
    func getMovies() -> [Movie] {
        guard let data = userDefaults.data(forKey: moviesKey) else {
            return []
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Movie].self, from: data)
        } catch {
            print("Error decoding data: \(error)")
            return []
        }
    }

    func setMovies(_ movies: [Movie]) {
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try encoder.encode(movies)
            userDefaults.set(data, forKey: moviesKey)
        } catch {
            print("Error encoding data: \(error)")
        }
    }
    
    // MARK: - Genre
    
    func getGenres() -> [Genre] {
        guard let data = userDefaults.data(forKey: genresKey) else {
            return []
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Genre].self, from: data)
        } catch {
            print("Error decoding data: \(error)")
            return []
        }
    }

    func setGenres(_ genres: [Genre]) {
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try encoder.encode(genres)
            userDefaults.set(data, forKey: genresKey)
        } catch {
            print("Error encoding data: \(error)")
        }
    }
}
