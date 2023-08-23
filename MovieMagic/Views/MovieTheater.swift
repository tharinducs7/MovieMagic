//
//  MovieTheater.swift
//  MovieMagic
//
//  Created by Tharindu Senadheera on 8/9/23.
//

import SwiftUI
import MapKit

struct MovieTheater: View {
    let userLocation = CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612)
   
    @StateObject private var locationManager = LocationManager()
    @ObservedObject var locationViewModel = LocationViewModel()
    @State private var selectedTheater: Theater?
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
         center: CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612),
         span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
     )

    
    let theaters: [Theater] = [
        Theater(id: 1, name: "Colombo City Cinema", latitude: 6.9271, longitude: 79.8612, description: "A popular movie theater in the heart of Colombo."),
        Theater(id: 2, name: "Liberty Lite Cinema", latitude: 6.9278, longitude: 79.8437, description: "A modern cinema located in the Liberty Plaza shopping complex."),
        Theater(id: 3, name: "Majestic Cineplex", latitude: 6.9126, longitude: 79.8499, description: "A multiplex cinema known for its luxurious seating and facilities."),
        Theater(id: 4, name: "Savoy 3D", latitude: 6.9155, longitude: 79.8576, description: "A theater offering 3D movie experiences."),
        Theater(id: 5, name: "Empire Cineplex", latitude: 6.9276, longitude: 79.8451, description: "An iconic cinema with a history dating back to colonial times."),
        Theater(id: 6, name: "Kandy Cinema", latitude: 7.2906, longitude: 80.6337, description: "A movie theater located in the picturesque city of Kandy."),
        Theater(id: 7, name: "Galle Movieplex", latitude: 6.0324, longitude: 80.2170, description: "A modern movie theater in the coastal city of Galle."),
    ]

    
    var nearestTheater: Theater? {
           theaters.min(by: { theater1, theater2 in
               let location1 = CLLocation(latitude: theater1.latitude, longitude: theater1.longitude)
               let location2 = CLLocation(latitude: theater2.latitude, longitude: theater2.longitude)
               
               if let location = locationViewModel.userLocation {
                   print("actual")
                   return location1.distance(from: CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)) <
                    location2.distance(from: CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
               } else {
                   return location1.distance(from: CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)) <
                    location2.distance(from: CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude))
               }
               
           })
       }
    
    var defaultMapCoordinate: CLLocationCoordinate2D {
        if let theater = selectedTheater {
            return CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
        } else if let nearest = nearestTheater {
            return CLLocationCoordinate2D(latitude: nearest.latitude, longitude: nearest.longitude)
        } else {
            if let location = locationViewModel.userLocation {
                return CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

            } else {
                return userLocation
            }

        }
    }
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    // Map and location information
                    Map(coordinateRegion: $region,
                        showsUserLocation: false,
                        userTrackingMode: .constant(.follow),
                        annotationItems: theaters) { theater in
                        MapMarker(coordinate: CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude), tint: nearestTheater == theater ? .blue : selectedTheater == theater ? .yellow:  .red)
                    }
                    .ignoresSafeArea()
                    .frame(height: 300)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                let delta = value - 1.0
                                let span = region.span
                                let newSpan = MKCoordinateSpan(
                                    latitudeDelta: span.latitudeDelta * delta,
                                    longitudeDelta: span.longitudeDelta * delta
                                )
                                region.span = newSpan
                            }
                    )

                    HStack {
                        Button(action: {
                            let span = region.span
                            let newSpan = MKCoordinateSpan(
                                latitudeDelta: span.latitudeDelta * 0.8,
                                longitudeDelta: span.longitudeDelta * 0.8
                            )
                            region.span = newSpan
                        }) {
                            Image(systemName: "plus.magnifyingglass")
                            Text("Zoom In")
                        }
                        .padding()

                        Button(action: {
                            let span = region.span
                            let newSpan = MKCoordinateSpan(
                                latitudeDelta: span.latitudeDelta * 1.25,
                                longitudeDelta: span.longitudeDelta * 1.25
                            )
                            region.span = newSpan
                        }) {
                            Image(systemName: "minus.magnifyingglass")
                            Text("Zoom Out")
                        }
                        .padding()
                    }


                    HStack {
                        Text("Nearest Theater")
                            .fontDesign(.rounded)
                        
                        Spacer()
                        
                        Text("📍 \(nearestTheater?.name ?? "None")")
                            .fontDesign(.rounded)
                       
                    }
                    .onTapGesture {
                        if let nearestTheater = nearestTheater {
                               selectedTheater = nearestTheater
                               updateMapRegion(for: nearestTheater)
                           }
                    }
                    .padding(20)
                    
                }

              
                List(theaters, id: \.id) { theater in
                    HStack(spacing: 20) {
                        Text(theater.name)
                        
                        Spacer()
                        
                        Text( selectedTheater == theater ?
                              "🍿":  "🎬")
                    }
                    .onTapGesture {
                        selectedTheater = theater
                        updateMapRegion(for: theater)
                    }
               
                    
                }
                .listStyle(PlainListStyle())
               // .frame(width: infinity)
               // .border(Color.gray)
            }
        }
    }
    
    func updateMapRegion(for theater: Theater) {
        withAnimation {
            region.center = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
        }
    }
}

struct MovieTheater_Previews: PreviewProvider {
    static var previews: some View {
        MovieTheater()
    }
}
