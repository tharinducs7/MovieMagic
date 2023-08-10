//
//  Theater.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/9/23.
//

import Foundation
import SwiftUI
import MapKit

struct Theater: Identifiable {
    let id = UUID()
    let name: String
    let location: CLLocationCoordinate2D
}

let theaters: [Theater] = [
    Theater(name: "Theater 1", location: CLLocationCoordinate2D(latitude: 6.9335, longitude: 79.8437)),
    Theater(name: "Theater 2", location: CLLocationCoordinate2D(latitude: 6.9274, longitude: 79.8787)),
    Theater(name: "Theater 3", location: CLLocationCoordinate2D(latitude: 6.9460, longitude: 79.8690))
]
