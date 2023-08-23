//
//  OnBoarding.swift
//  MovieMagic
//
//  Created by Yelka Kariywasam on 8/20/23.
//

import SwiftUI

struct OnBoardingStep {
    let image: String
    let title: String
    let description: String
}

private let onBoardingSteps = [
    OnBoardingStep(image: "logo", title: "Who we are?", description: "Discover and save your favorite movies with a convenient app. Find films from different genres and easily mark them as favorites for future enjoyment. Your personal movie guide for creating a go-to list of top picks."),
    OnBoardingStep(image: "logo", title: "So, who are you?", description: "Share your username and email so we can assist you properly, like getting to know you in the online world."),
    OnBoardingStep(image: "logo", title: "Which genres are you into the most?", description: "We want to know your favorite movie types, like action, romance, horror, and more. It's like asking which flavors you like best from a big buffet of movies")
]

struct OnBoarding: View {
    @State private var isActive = false
    @State private var currentStep = 0
    @StateObject private var genreVM = GenreViewModel()
    @State private var selectedGenres: Set<String> = []
    @State private var name: String = ""
    @State private var email: String = ""
    
    
    var body: some View {
        if isActive {
            ContentView()
        }  else {
            
            VStack {
                TabView(selection: $currentStep) {
                    ForEach(0..<onBoardingSteps.count) { step in
                        VStack {
                            Image(onBoardingSteps[step].image)
                                .resizable()
                                .frame(width: 250, height: 250)
                            
                            Text(onBoardingSteps[step].title)
                                .font(.title3)
                                .bold()
                            
                            if currentStep == 2 {
                                ScrollView(.horizontal) {
                                    HStack(spacing: 10) {
                                        ForEach(genreVM.genres) { genre in
                                            GenreSelection(genre: genre, selectedGenres: $selectedGenres)
                                                .animation(.default)
                                        }
                                    }
                                }
                                .padding(10)
                            }
                            
                            if currentStep == 1 {
                                VStack(alignment: .leading, spacing: 0) {
                                    CustomLable(labelText: "User Name")
                                        .padding(.bottom, 8)
                                    
                                    TextField("Enter user name", text: $name)
                                        .padding(.top, 8)
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                    
                                }.listRowSeparator(.hidden)
                                    .padding(10)
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    CustomLable(labelText: "Email")
                                        .padding(.bottom, 8)
                                    
                                    TextField("Enter Email Address", text: $email)
                                        .padding(.top, 8)
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                    
                                }.listRowSeparator(.hidden)
                                    .padding(10)
                                
                            }
                            
                            Text(onBoardingSteps[step].description)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                                .padding(.top, 16)
                            
                        }
                        .tag(step)
                    }
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                Spacer()
                
                Button(action: {
                    if self.currentStep < onBoardingSteps.count - 1 {
                        self.currentStep += 1
                    } else {
                        var newUser: User = User(id: UUID(), name: name, email: email, favoriteGenres: Array(selectedGenres))
                        
                        DataManager.shared.setUser(newUser)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation(.spring()) {
                                self.isActive = true
                            }
                        }
                            
                    }
                }) {
                    Text(currentStep < onBoardingSteps.count - 1 ? "Next" : "Get Started")
                        .padding(16)
                        .frame(maxWidth:.infinity)
                        .background(Color("Purple"))
                        .cornerRadius(16)
                        .padding(.horizontal, 16)
                        .foregroundColor(.white)
                    
                }
                
            }
        }
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}
