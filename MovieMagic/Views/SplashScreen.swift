//
//  SplashScreen.swift
//  MovieMagic
//
//  Created by Yelka Kariywasam on 8/22/23.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    @State private var user: User? = DataManager.shared.getUser()
   
    
    var body: some View {
        if isActive {
            if user != nil {
                ContentView()
            } else {
                OnBoarding()
            }
        } else {
            
            VStack {
                VStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 300, height: 300)
                    
                    Text("By iGenius")
                        .font(.caption)
                        .fontWeight(.light)
                        .fontDesign(.rounded)
                }
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 2)) {
                    self.size = 0.9;
                    self.opacity = 1.0;
                }
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.spring()) {
                        self.isActive = true
                    }
                    
                }
            }
            
        }
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
