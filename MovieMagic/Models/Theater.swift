//
//  Theater.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/9/23.
//

import Foundation
import SwiftUI
import MapKit

struct Theater: Identifiable, Codable , Equatable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let description: String
}

//let theaters: [Theater] = [
//    Theater(name: "Theater 1", latitude: 6.9335, longitude: 79.8437, description: "test "),
//    Theater(name: "Theater 2", latitude: 6.9274, longitude: 79.8787,description: "test "),
//    Theater(name: "Theater 3", latitude: 6.9460, longitude: 79.8690,description: "test ")
//]


//let theaters: [Theater] = [
//    Theater(name: "Theater 1", latitude, longitude location: CLLocationCoordinate2D(latitude: 6.9335, longitude: 79.8437)),
//    Theater(name: "Theater 2", location: CLLocationCoordinate2D(latitude: 6.9274, longitude: 79.8787)),
//    Theater(name: "Theater 3", location: CLLocationCoordinate2D(latitude: 6.9460, longitude: 79.8690))
//]
