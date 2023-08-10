//
//  CustomLable.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/7/23.
//

import SwiftUI

import SwiftUI

struct CustomLable: View {
    var labelText: String
    
    var body: some View {
        Label(labelText, systemImage: "info.circle")
            .fontDesign(.rounded)
            .fontWeight(.semibold)
            .foregroundColor(.gray)
            .labelStyle(.titleOnly)
    }
}

struct CustomLable_Previews: PreviewProvider {
    static var previews: some View {
        CustomLable(labelText: "iGenius")
    }
}

