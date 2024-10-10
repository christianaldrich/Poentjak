//
//  EmergencyProsesView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 29/09/24.
//

import SwiftUI
import CoreLocation

struct EmergencyProsesView: View {
    // @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = EmergencyProsesViewModel()
    @StateObject var navigateViewModel = UserNavigateViewModel()
    
    var body: some View {
        NavigationStack{
            
            VStack (alignment: .center){
                
                NavigationLink(destination: DetailPostView(viewModel: navigateViewModel)) { // Navigate to DetailPostView when tapped
                    HStack {
                        if !navigateViewModel.isSOS{
                            if !navigateViewModel.isReverseNavigation {
                                if navigateViewModel.currentWaypointIndex < navigateViewModel.gpxParser.parsedWaypoints.count {
                                    let currentWaypoint = navigateViewModel.gpxParser.parsedWaypoints[navigateViewModel.currentWaypointIndex]
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
                                    Text("Reversing Waypoints...")
                                        .padding()
                                }
                            } else {
                                // Show ETA from the last waypoint in reverse
                                if navigateViewModel.currentWaypointIndex >= 0 {
                                    let currentWaypoint = navigateViewModel.gpxParser.parsedWaypoints[navigateViewModel.currentWaypointIndex]
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
            
            UserNavigateView(viewModel: navigateViewModel)
            
            Button("I am back at basecamp"){
                Task{
                    await viewModel.updateSessionDone()
                    navigateViewModel.isNavigating = false
                    navigateViewModel.stopTimer()
                    navigateViewModel.locationManager.resetTotalDistance()
                    
                    //                    print("\(viewModel.sessionId)")
                    //                               presentationMode.wrappedValue.dismiss()
                    
                }
            }
            
        }
        .onAppear{
            viewModel.fetchEmergency()
            navigateViewModel.isNavigating = true
            navigateViewModel.startTimer()
        }
        
    }
}

#Preview {
    EmergencyProsesView()
}
