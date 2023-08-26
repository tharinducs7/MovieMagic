//
//  NewList.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/25/23.
//

//
//  RecomendedList.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/25/23.
//

import SwiftUI

struct NewList: View {
    @State private var selectedMovie: Movie?
    @StateObject private var movieVM = MoviesViewModel()
    @State private var user: User? = DataManager.shared.getUser()
    let currentYear = Calendar.current.component(.year, from: Date())
    var formattedCurrentYear: String {
           let numberFormatter = NumberFormatter()
           numberFormatter.numberStyle = .none
           return numberFormatter.string(from: NSNumber(value: currentYear)) ?? "\(currentYear)"
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Movies in \(formattedCurrentYear)")
                        .font(.headline)
                        .fontDesign(.rounded)
                    
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, -40)
            .padding(.top, 20)
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 50) {
                    ForEach(filteredMovies) { movie in
                        GeometryReader { geometry in
                            
                            let x = geometry.frame(in: .global).minX
                            let scale = getScale(proxy: geometry)
                            
                            MovieCardTypeB(movie: movie)
                                .clipped()
                                .scaleEffect(CGSize(width: scale, height: scale))
                        }
                        .frame(width: 130, height: 300)
                    }
                }
                .padding(10)
                .padding(.top, -80)
                .padding(.bottom, 50)
                
                Spacer()
            }
            .onAppear() {
                if let userEmail = user?.email {
                    movieVM.fetchFavoritMoviesByUser(by: userEmail)
                }
                
                print("Test FFF")
                
            }
            
        }
    }
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        
        let x = proxy.frame(in: .global).minX
        let diff = abs(x)
        
        if diff < 100 {
            scale = 1 + diff / 500
        }
        return scale
    }
    
    var filteredMovies: [Movie] {
        return movieVM.movies.filter { $0.year == currentYear }
    }
    
    
}

struct NewList_Previews: PreviewProvider {
    static var previews: some View {
        NewList()
    }
}
