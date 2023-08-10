//
//  HideKeyboard.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/7/23.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
