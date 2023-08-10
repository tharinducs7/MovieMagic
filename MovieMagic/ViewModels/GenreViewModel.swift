//
//  GenreViewModel.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/7/23.
//

import Foundation


final class GenreViewModel: ObservableObject {
    @Published var genres: [Genre] = []

    init() {
        fetchGenres()
    }
    
    func fetchGenres() {
        URLSession.shared.dataTask(with: MovieConstants.genresURL) { [weak self] data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedData = try decoder.decode([Genre].self, from: data)
                
                DispatchQueue.main.async {
                    self?.genres = decodedData
                    DataManager.shared.setGenres(decodedData)
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}
