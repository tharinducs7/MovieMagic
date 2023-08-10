//
//  MovieTheater.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/9/23.
//

import SwiftUI
import MapKit

struct MovieTheater: View {
    let userLocation = CLLocationCoordinate2D(latitude: 7.2964, longitude: 80.6350)
    
    @StateObject private var locationManager = LocationManager()
    @ObservedObject var locationViewModel = LocationViewModel()
    @State private var selectedTheater: Theater?
    
    // User's location in Sri Lanka
    
    let theaters: [Theater] = [
        Theater(name: "Theater 1", location: CLLocationCoordinate2D(latitude: 6.9335, longitude: 79.8437)),
        Theater(name: "Theater 2", location: CLLocationCoordinate2D(latitude: 6.9274, longitude: 79.8787)),
        Theater(name: "Theater 3", location: CLLocationCoordinate2D(latitude: 6.9460, longitude: 79.8690)),
        Theater(name: "Theater 4", location: CLLocationCoordinate2D(latitude: 7.2915, longitude: 80.6350)), // Kandy
        Theater(name: "Theater 5", location: CLLocationCoordinate2D(latitude: 7.2964, longitude: 80.6350)), // Kandy
        Theater(name: "Theater 6", location: CLLocationCoordinate2D(latitude: 6.0273, longitude: 80.2170)), // Galle
        Theater(name: "Theater 7", location: CLLocationCoordinate2D(latitude: 6.0404, longitude: 80.2170)), // Galle
        Theater(name: "Theater 8", location: CLLocationCoordinate2D(latitude: 6.7114, longitude: 79.9749)),
    ]
    
    var nearestTheater: Theater? {
        theaters.min(by: { theater1, theater2 in
            let location1 = CLLocation(latitude: theater1.location.latitude, longitude: theater1.location.longitude)
            let location2 = CLLocation(latitude: theater2.location.latitude, longitude: theater2.location.longitude)
            return location1.distance(from: CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)) <
                   location2.distance(from: CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude))
        })
    }
    
    
    var body: some View {
        VStack {
            VStack {
                if let location = locationViewModel.userLocation {
                    Text("Latitude: \(location.coordinate.latitude)")
                    Text("Longitude: \(location.coordinate.longitude)")
                } else {
                    Text("Fetching location...")
                }
                
                Map(coordinateRegion: .constant(
                        MKCoordinateRegion(
                            center: selectedTheater?.location ?? nearestTheater?.location ?? userLocation,
                            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
                        )
                    ),
                    showsUserLocation: true,
                    userTrackingMode: .constant(.follow),
                    annotationItems: theaters) { theater in
                        MapMarker(coordinate: theater.location, tint: selectedTheater?.name == theater.name ? .blue : .red)
                }
                .frame(height: 300)
                .onTapGesture {
                    print(selectedTheater?.name)
                }
                
                Text("Nearest Theater: \(nearestTheater?.name ?? "None")")
            }
                    List(theaters, id: \.name) { theater in
                        Text(theater.name)
                            .onTapGesture {
                                print(theater)
                                selectedTheater = theater
                            }
                    }
                    .frame(width: 200)
                    .border(Color.gray) // Optional: Add a border to the list
                    
                 
                }
            }

}

struct MovieTheater_Previews: PreviewProvider {
    static var previews: some View {
        MovieTheater()
    }
}
