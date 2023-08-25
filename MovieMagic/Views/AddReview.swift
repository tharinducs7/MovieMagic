//
//  AddReview.swift
//  MovieMagic
//
//  Created by Diliru on 2023-08-15.
//

import SwiftUI

struct AddReview: View {
    var movie: Movie
    @State private var reviewContent: String = ""
    @State private var reviewTitle: String = ""
    @State private var rating = 0
    @StateObject private var movieVM = MoviesViewModel()
    @ObservedObject var reviewsViewModel = ReviewsViewModel()
    @State private var user: User? = DataManager.shared.getUser()
    @State private var showAlert = false
    @State private var alertTtitle: String = ""
    @State private var alretMsg: String = ""
    
    enum FocusField {
        case reviewContentField,reviewTitleField
    }
    
    @FocusState private var focusedField: FocusField?
    
    var body: some View {
        NavigationView {
            List {
                MovieHeader(movie: movie)
                
                VStack(alignment: .leading, spacing: 0) {
                    CustomLable(labelText: "Rating")
                    
                    StarRatingComponent(rating: $rating)
                        .padding(.top, 15)
                    
                }.listRowSeparator(.hidden)
                    .padding(5)
                
                VStack(alignment: .leading, spacing: 0) {
                    CustomLable(labelText: "Review Title")
                        .padding(.bottom, 8)
                    
                    TextField("Enter review Title", text: $reviewTitle)
                        .focused($focusedField, equals: .reviewTitleField)
                        .padding(.top, 8)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                }.listRowSeparator(.hidden)
                    .padding(10)
                
                
                VStack(alignment: .leading, spacing: 0) {
                    CustomLable(labelText: "Review Description")
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                        
                        TextEditor(text: $reviewContent)
                            .focused($focusedField, equals: .reviewContentField)
                            .frame(height: 150)
                    }
                    .padding(.top, 10)
                    
                }.listRowSeparator(.hidden)
                    .padding(10)
                
                Button(action: {
                    print("error")
                    if reviewContent.isEmpty || reviewTitle.isEmpty || rating == 0 {
                        showAlert = true
                        print("error")
                        self.alertTtitle = "Validation Error"
                        self.alretMsg = "Please fill in all the required fields."
                    } else {
                        if let userName = user?.name, let userEmail = user?.email {
                            let newReview = MovieReview(
                                id: 0,
                                movieId: movie.id,
                                userName: userName,
                                email: userEmail,
                                rating: rating,
                                review: reviewContent,
                                reviewTitle: reviewTitle
                            )
                            
                            reviewsViewModel.submitReview(review: newReview)
                        } else {
                            
                            print("test")
                            // Handle the case where user's name or email is nil
                        }
                    }
                    
                }) {
                    HStack {
                        
                        Text("SAVE")
                            .bold()
                            .foregroundColor(.white)
                            .fontDesign(.rounded)
                            .font(.title2)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(6)
                    .background(Color("Purple"))
                    .cornerRadius(10)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .controlSize(.large)
                }
                .alert(isPresented: $showAlert) {
                       Alert(title: Text(alertTtitle),
                             message: Text(alretMsg),
                             dismissButton: .default(Text("OK")))
                   }
                .padding(10)
               
            }
            .toolbar{
                ToolbarItem(placement: .keyboard){
                    Button {
                        self.reviewContent = ""
                    } label: {
                        Image(systemName: "eraser.line.dashed.fill")
                    }
                }
                ToolbarItem(placement: .keyboard){
                    Button {
                        focusedField =  nil
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down.fill")
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("New Review").fontDesign(.rounded)
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
        .navigationViewStyle(.stack)
//        .onTapGesture {
//            self.hideKeyboard()
//        }
    }
}


struct AddReview_Previews: PreviewProvider {
    static var previews: some View {
        AddReview(movie: sampleMovies[0])
    }
}
