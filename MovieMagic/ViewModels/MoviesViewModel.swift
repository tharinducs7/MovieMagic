//
//  MoviesViewModel.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/6/23.
//

import Foundation


final class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var trendingMovies: [Movie] = []
    @Published var selectedGenre: String = "Action"
    @Published var favoriteMovies: [Movie] = []
    @Published var movieById: Movie? = nil
    private var user: User? = DataManager.shared.getUser()
    
    
    init() {
        fetchMovies()
        fetchTrendingMovies()
        
        if let userEmail = user?.email {
            fetchFavoritMoviesByUser(by: userEmail)
        }
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
    
    func fetchTrendingMovies() {
        URLSession.shared.dataTask(with: MovieConstants.trendingMoviesURL) { [weak self] data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedData = try decoder.decode([Movie].self, from: data)
                
                DispatchQueue.main.async {
                    self?.trendingMovies = decodedData
                    DataManager.shared.setTredingMovies(decodedData) // Update DataManager with new data
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
    
    func fetchFavoritMoviesByUser(by email: String) {
        let string = "https://cvtub8qk88.execute-api.ap-south-1.amazonaws.com/dev/movie/favorite/\(email)"
       
        URLSession.shared.dataTask(with: URL(string: string)!) { [weak self] data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedData = try decoder.decode([Movie].self, from: data)
                print(decodedData, "fav")
                DispatchQueue.main.async {
                    self?.favoriteMovies = decodedData
                    
                   
                    DataManager.shared.setFavoriteMovies(decodedData) // Update DataManager with new data
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
    
    func addFavoriteMovies(movieId: Int, email: String) {
        let string = "https://cvtub8qk88.execute-api.ap-south-1.amazonaws.com/dev/movie/favorite/\(movieId)"
       
        var request = URLRequest(url: URL(string: string)!)
        request.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            let requestData = try encoder.encode(["email": email]) // Encode email as JSON
            
            request.httpBody = requestData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error submitting review: \(error)")
                    return
                }
                
                // Handle response if needed
                if let httpResponse = response as? HTTPURLResponse {
                    print(" added: \(httpResponse.statusCode)")
                    // Handle response status codes here
                }
                
            }.resume()
        } catch {
            print("Error encoding review data: \(error)")
        }
    }
    
    func removeFavoriteMovies(movieId: Int, email: String) {
        let string = "https://cvtub8qk88.execute-api.ap-south-1.amazonaws.com/dev/movie/favorite/\(movieId)"
       
        var request = URLRequest(url: URL(string: string)!)
        request.httpMethod = "DELETE"
        
        do {
            let encoder = JSONEncoder()
            let requestData = try encoder.encode(["email": email]) // Encode email as JSON
            
            request.httpBody = requestData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error submitting review: \(error)")
                    return
                }
                
                // Handle response if needed
                if let httpResponse = response as? HTTPURLResponse {
                    print("removed: \(httpResponse.statusCode)")
                    // Handle response status codes here
                }
                
            }.resume()
        } catch {
            print("Error encoding review data: \(error)")
        }
    }
    
    func fetchMovieByID(by id: Int) {
        let string = "https://cvtub8qk88.execute-api.ap-south-1.amazonaws.com/dev/movie/\(id)"
       
        URLSession.shared.dataTask(with: URL(string: string)!) { [weak self] data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedData = try decoder.decode(Movie.self, from: data)
                print(decodedData, "again 22")
                DispatchQueue.main.async {
                    self?.movieById = decodedData
                    DataManager.shared.setMovieById(decodedData) // Update DataManager with new data
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
  
//    func checkIfEmailExists() -> Bool {
//        let userEmail = user?.email ?? ""
//       // let favoriteMovies = movie.favorites ?? []
//
////        if(favoriteMovies.contains(userEmail)) {
////            self.favToggle = true
////        } else {
////            self.favToggle = false
////        }
//
//      //  return favoriteMovies.contains(userEmail)
//    }

    func refreshData() {
        print("refreshing........")
        self.movies = [] // Clear existing movies
        self.trendingMovies = [] // Clear existing trending movies
        fetchMovies()
        fetchTrendingMovies()
        if let userEmail = user?.email {
            fetchFavoritMoviesByUser(by: userEmail)
        }
    }
}
