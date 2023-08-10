//
//  MoviesViewModel.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/6/23.
//

import Foundation


final class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var selectedGenre: String = "Action"
    
    init() {
        fetchMovies()
    }
    
    func fetchMovies() {
        URLSession.shared.dataTask(with: MovieConstants.moviesURL) { [weak self] data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedData = try decoder.decode([Movie].self, from: data)
                
                DispatchQueue.main.async {
                    self?.movies = decodedData
                    DataManager.shared.setMovies(decodedData) // Update DataManager with new data
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
    
    func filterMovies(by genre: String) {
        URLSession.shared.dataTask(with: MovieConstants.moviesURL) { [weak self] data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedData = try decoder.decode([Movie].self, from: data)
                
                let filteredMovies = decodedData.filter { movie in
                    movie.genre.contains(genre)
                }
                
                DispatchQueue.main.async {
                    self?.movies = filteredMovies
                    DataManager.shared.setMovies(filteredMovies) // Update DataManager with new data
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
    
    // Function to search movies by title
    func searchMovies(by title: String) {
        URLSession.shared.dataTask(with: MovieConstants.moviesURL) { [weak self] data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedData = try decoder.decode([Movie].self, from: data)
                if(title.isEmpty) {
                    DispatchQueue.main.async {
                        self?.movies = decodedData
                        DataManager.shared.setMovies(decodedData) // Update DataManager with new data
                    }
                    print(title)
                } else {
                    let filteredMovies = decodedData.filter { movie in
                        movie.title.localizedCaseInsensitiveContains(title)
                    }
                    
                    print(filteredMovies)

                    
                    DispatchQueue.main.async {
                        self?.movies = filteredMovies
                        DataManager.shared.setMovies(filteredMovies) // Update DataManager with new data
                    }
                }
                
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}
