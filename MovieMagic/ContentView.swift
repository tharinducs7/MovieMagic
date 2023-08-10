//
//  ContentView.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabBarComponent()
            .ignoresSafeArea(.keyboard)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
