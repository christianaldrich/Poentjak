//
//  TopETAView.swift
//  Poentjak
//
//  Created by Shan Havilah on 15/10/24.
//

import SwiftUI
import CoreLocation

struct TopETAView: View {
    @StateObject var navigateViewModel = UserNavigateViewModel(fileName: "")
    
    var body: some View {
        VStack{
            NavigationLink(destination: DetailPostView(viewModel: navigateViewModel)) { // Navigate to DetailPostView when tapped
                HStack {
                    if !navigateViewModel.isSOS{
                        if !navigateViewModel.isReverseNavigation {
                            if navigateViewModel.currentWaypointIndex < navigateViewModel.gpxParser.parsedWaypointsPos.count {
                                let currentWaypoint = navigateViewModel.gpxParser.parsedWaypointsPos[navigateViewModel.currentWaypointIndex]
                                if let eta = navigateViewModel.calculateETA(
                                    to: CLLocationCoordinate2D(latitude: currentWaypoint.latitude, longitude: currentWaypoint.longitude),
                                    waypointElevation: currentWaypoint.elevation,
                                    userLocation: navigateViewModel.locationManager.lastKnownLocation ?? CLLocationCoordinate2D(),
                                    userElevation: navigateViewModel.locationManager.currentElevation,
                                    speed: navigateViewModel.locationManager.currentSpeed
                                ) {
                                    Text("\(currentWaypoint.name): ETA \(String(format: "%.1f", eta)) min")
                                        .padding()
                                } else {
                                    Text("\(currentWaypoint.name): N/A")
                                        .padding()
                                }
                            } else {
                                Text("Don't forget to return")
                                    .padding()
                            }
                        } else {
                            // Show ETA from the last waypoint in reverse
                            if navigateViewModel.currentWaypointIndex >= 0 {
                                let currentWaypoint = navigateViewModel.gpxParser.parsedWaypointsPos[navigateViewModel.currentWaypointIndex]
                                if let eta = navigateViewModel.calculateETA(
                                    to: CLLocationCoordinate2D(latitude: currentWaypoint.latitude, longitude: currentWaypoint.longitude),
                                    waypointElevation: currentWaypoint.elevation,
                                    userLocation: navigateViewModel.locationManager.lastKnownLocation ?? CLLocationCoordinate2D(),
                                    userElevation: navigateViewModel.locationManager.currentElevation,
                                    speed: navigateViewModel.locationManager.currentSpeed
                                ) {
                                    Text("\(currentWaypoint.name): ETA \(String(format: "%.1f", eta)) min")
                                        .padding()
                                } else {
                                    Text("\(currentWaypoint.name): N/A")
                                        .padding()
                                }
                            } else {
                                Text("Reached basecamp!")
                                    .padding()
                            }
                        }
                    } else {
                        // Show the nearest Warung and ETA to get there
                        if let nearestWarung = navigateViewModel.nearestWarung {
                            let eta = navigateViewModel.calculateETA(
                                to: CLLocationCoordinate2D(latitude: nearestWarung.latitude, longitude: nearestWarung.longitude),
                                waypointElevation: nearestWarung.elevation,
                                userLocation: navigateViewModel.locationManager.lastKnownLocation ?? CLLocationCoordinate2D(),
                                userElevation: navigateViewModel.locationManager.currentElevation,
                                speed: navigateViewModel.locationManager.currentSpeed
                            )
                            
                            if let eta = eta {
                                Text("Nearest Warung: \(nearestWarung.name), ETA: \(String(format: "%.1f", eta)) min")
                                    .padding()
                            } else {
                                Text("Nearest Warung: \(nearestWarung.name), ETA: N/A")
                                    .padding()
                            }
                        } else {
                            Text("No Warung found nearby")
                                .padding()
                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    TopETAView()
}
