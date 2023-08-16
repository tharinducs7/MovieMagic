//
//  ReviewsViewModel.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/15/23.
//

import Foundation

final class ReviewsViewModel: ObservableObject {
    @Published var reviews: [MovieReview] = []

    init() {
        fetchReviews()
    }
    
    func fetchReviews() {
        URLSession.shared.dataTask(with: MovieConstants.reviewsURL) { [weak self] data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
               // decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedData = try decoder.decode([MovieReview].self, from: data)
                
                DispatchQueue.main.async {
                    self?.reviews = decodedData
                    DataManager.shared.setReviews(decodedData)
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
    
    func submitReview(review: MovieReview) {
        var request = URLRequest(url: MovieConstants.reviewsURL)
        request.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
           // encoder.keyEncodingStrategy = .convertToSnakeCase
            let reviewData = try encoder.encode(review)
            
            request.httpBody = reviewData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error submitting review: \(error)")
                    return
                }
                
                // Handle response if needed
                if let httpResponse = response as? HTTPURLResponse {
                    print("Response status code: \(httpResponse.statusCode)")
                    // Handle response status codes here
                }
                
            }.resume()
        } catch {
            print("Error encoding review data: \(error)")
        }
    }


}
