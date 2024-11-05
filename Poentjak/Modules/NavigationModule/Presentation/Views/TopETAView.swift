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
    @State private var navigateToDetail = false // State variable to control navigation
    @Binding var isShowingModal: Bool

    var body: some View {
        VStack {
            HStack {
                if !navigateViewModel.isSOS {
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
                                CustomDirectionsCard(
                                    status: DirectionCardStatus.default,
                                    checkpointTitle: currentWaypoint.checkPointStatus == "summit" ? "Summit" : "Checkpoint \(currentWaypoint.idx)",
                                    etaText: "ETA \(String(format: "%.0f", eta)) min",
                                    altitude: Int(currentWaypoint.elevation),
                                    overdueText: "15 mins left till overdue"
                                ) {
                                    isShowingModal = false
                                    navigateToDetail = true // Set navigation state on button tap
                                }
                            } else {
                                CustomDirectionsCard(
                                    status: DirectionCardStatus.default,
                                    checkpointTitle: currentWaypoint.checkPointStatus == "summit" ? "Summit" : "Checkpoint \(currentWaypoint.idx)",
                                    etaText: "Not yet walk",
                                    altitude: Int(currentWaypoint.elevation),
                                    overdueText: "15 mins left till overdue"
                                ) {
                                    isShowingModal = false
                                    navigateToDetail = true // Set navigation state on button tap
                                }
                            }
                        } else {
                            Text("Don't forget to return")
                                .padding()
                        }
                    } else {
                        if navigateViewModel.currentWaypointIndex >= 0 {
                            let currentWaypoint = navigateViewModel.gpxParser.parsedWaypointsPos[navigateViewModel.currentWaypointIndex]
                            if let eta = navigateViewModel.calculateETA(
                                to: CLLocationCoordinate2D(latitude: currentWaypoint.latitude, longitude: currentWaypoint.longitude),
                                waypointElevation: currentWaypoint.elevation,
                                userLocation: navigateViewModel.locationManager.lastKnownLocation ?? CLLocationCoordinate2D(),
                                userElevation: navigateViewModel.locationManager.currentElevation,
                                speed: navigateViewModel.locationManager.currentSpeed
                            ) {
                                CustomDirectionsCard(
                                    status: DirectionCardStatus.default,
                                    checkpointTitle: currentWaypoint.checkPointStatus == "summit" ? "Summit" : "Checkpoint \(currentWaypoint.idx)",
                                    etaText: "ETA \(String(format: "%.1f", eta)) min",
                                    altitude: Int(currentWaypoint.elevation),
                                    overdueText: "15 mins left till overdue"
                                ) {
                                    isShowingModal = false
                                    navigateToDetail = true
                                }
                            } else {
                                CustomDirectionsCard(
                                    status: DirectionCardStatus.default,
                                    checkpointTitle: currentWaypoint.checkPointStatus == "summit" ? "Summit" : "Checkpoint \(currentWaypoint.idx)",
                                    etaText: "N/A",
                                    altitude: Int(currentWaypoint.elevation),
                                    overdueText: "15 mins left till overdue"
                                ) {
                                    isShowingModal = false
                                    navigateToDetail = true
                                }
                            }
                        } else {
                            Text("Reached basecamp!")
                                .padding()
                        }
                    }
                } else {
                    if let nearestWarung = navigateViewModel.nearestWarung {
                        let eta = navigateViewModel.calculateETA(
                            to: CLLocationCoordinate2D(latitude: nearestWarung.latitude, longitude: nearestWarung.longitude),
                            waypointElevation: nearestWarung.elevation,
                            userLocation: navigateViewModel.locationManager.lastKnownLocation ?? CLLocationCoordinate2D(),
                            userElevation: navigateViewModel.locationManager.currentElevation,
                            speed: navigateViewModel.locationManager.currentSpeed
                        )
                        
                        if let eta = eta {
                            CustomDirectionsCard(
                                status: DirectionCardStatus.default,
                                checkpointTitle: nearestWarung.checkPointStatus == "summit" ? "Summit" : "Checkpoint \(nearestWarung.idx)",
                                etaText: "ETA \(String(format: "%.1f", eta)) min",
                                altitude: Int(nearestWarung.elevation),
                                overdueText: "15 mins left till overdue"
                            ) {
                                isShowingModal = false
                                navigateToDetail = true
                            }
                        } else {
                            CustomDirectionsCard(
                                status: DirectionCardStatus.default,
                                checkpointTitle: nearestWarung.checkPointStatus == "summit" ? "Summit" : "Checkpoint \(nearestWarung.idx)",
                                etaText: "N/A",
                                altitude: Int(nearestWarung.elevation),
                                overdueText: "15 mins left till overdue"
                            ) {
                                isShowingModal = false
                                navigateToDetail = true
                            }
                        }
                    } else {
                        Text("No Warung found nearby")
                            .padding()
                    }
                }
            }
            
            // NavigationLink triggered by the state variable
            NavigationLink(destination: DetailPostView(viewModel: navigateViewModel), isActive: $navigateToDetail) {
                EmptyView()
            }
        }
    }
}

//#Preview {
//    TopETAView()
//}
