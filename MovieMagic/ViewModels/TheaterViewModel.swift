//
//  TheaterViewModel.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/12/23.
//

import Foundation

final class TheaterViewModel: ObservableObject {
    @Published var theaters: [Theater] = []

    init() {
        fetchTheaters()
    }
    
    func fetchTheaters() {
        URLSession.shared.dataTask(with: MovieConstants.theatersURL) { [weak self] data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedData = try decoder.decode([Theater].self, from: data)
                
                DispatchQueue.main.async {
                    self?.theaters = decodedData
                    DataManager.shared.setGenres(decodedData)
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}
