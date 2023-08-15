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
                
                Button(action: {}) {
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
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}


struct AddReview_Previews: PreviewProvider {
    static var previews: some View {
        AddReview(movie: sampleMovies[0])
    }
}
