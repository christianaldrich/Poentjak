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
    @StateObject var viewModel : EmergencyProsesViewModel
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
                                if viewModel.sendSOSToFirebase && viewModel.isSignalSent {
                                    CustomDirectionsCard(
                                        status: DirectionCardStatus.sosSent,
                                        checkpointTitle: currentWaypoint.checkPointStatus == "summit" ? "Summit" : "Checkpoint \(currentWaypoint.idx)",
                                        etaText: "ETA \(String(format: "%.0f", eta)) min",
                                        altitude: Int(currentWaypoint.elevation),
                                        overdueText: "15 mins left till overdue"
                                    ) {
                                        isShowingModal = false
                                        navigateToDetail = true // Set navigation state on button tap
                                    }
                                } else if !viewModel.sendSOSToFirebase && viewModel.isSignalSent {
                                    CustomDirectionsCard(
                                        status: DirectionCardStatus.sos,
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
                                        etaText: "ETA \(String(format: "%.0f", eta)) min",
                                        altitude: Int(currentWaypoint.elevation),
                                        overdueText: "15 mins left till overdue"
                                    ) {
                                        isShowingModal = false
                                        navigateToDetail = true // Set navigation state on button tap
                                    }
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
                                if viewModel.sendSOSToFirebase && viewModel.isSignalSent {
                                    CustomDirectionsCard(
                                        status: DirectionCardStatus.sosSent,
                                        checkpointTitle: currentWaypoint.checkPointStatus == "summit" ? "Summit" : "Checkpoint \(currentWaypoint.idx)",
                                        etaText: "ETA \(String(format: "%.0f", eta)) min",
                                        altitude: Int(currentWaypoint.elevation),
                                        overdueText: "15 mins left till overdue"
                                    ) {
                                        isShowingModal = false
                                        navigateToDetail = true // Set navigation state on button tap
                                    }
                                } else if !viewModel.sendSOSToFirebase && viewModel.isSignalSent {
                                    CustomDirectionsCard(
                                        status: DirectionCardStatus.sos,
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
                                        etaText: "ETA \(String(format: "%.0f", eta)) min",
                                        altitude: Int(currentWaypoint.elevation),
                                        overdueText: "15 mins left till overdue"
                                    ) {
                                        isShowingModal = false
                                        navigateToDetail = true // Set navigation state on button tap
                                    }
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
                    if let nearestWaypoint = navigateViewModel.nearestWaypoint {
                        let eta = navigateViewModel.calculateETA(
                            to: CLLocationCoordinate2D(latitude: nearestWaypoint.latitude, longitude: nearestWaypoint.longitude),
                            waypointElevation: nearestWaypoint.elevation,
                            userLocation: navigateViewModel.locationManager.lastKnownLocation ?? CLLocationCoordinate2D(),
                            userElevation: navigateViewModel.locationManager.currentElevation,
                            speed: navigateViewModel.locationManager.currentSpeed
                        )
                        
                        if let eta = eta {
                            if viewModel.sendSOSToFirebase && viewModel.isSignalSent {
                                CustomDirectionsCard(
                                    status: DirectionCardStatus.sosSent,
                                    checkpointTitle: nearestWaypoint.checkPointStatus == "summit" ? "Summit" : "Checkpoint \(nearestWaypoint.idx)",
                                    etaText: "ETA \(String(format: "%.0f", eta)) min",
                                    altitude: Int(nearestWaypoint.elevation),
                                    overdueText: "15 mins left till overdue"
                                ) {
                                    isShowingModal = false
                                    navigateToDetail = true // Set navigation state on button tap
                                }
                            } else if !viewModel.sendSOSToFirebase && viewModel.isSignalSent {
                                CustomDirectionsCard(
                                    status: DirectionCardStatus.sos,
                                    checkpointTitle: nearestWaypoint.checkPointStatus == "summit" ? "Summit" : "Checkpoint \(nearestWaypoint.idx)",
                                    etaText: "ETA \(String(format: "%.0f", eta)) min",
                                    altitude: Int(nearestWaypoint.elevation),
                                    overdueText: "15 mins left till overdue"
                                ) {
                                    isShowingModal = false
                                    navigateToDetail = true // Set navigation state on button tap
                                }
                            } else {
                                CustomDirectionsCard(
                                    status: DirectionCardStatus.default,
                                    checkpointTitle: nearestWaypoint.checkPointStatus == "summit" ? "Summit" : "Checkpoint \(nearestWaypoint.idx)",
                                    etaText: "ETA \(String(format: "%.0f", eta)) min",
                                    altitude: Int(nearestWaypoint.elevation),
                                    overdueText: "15 mins left till overdue"
                                ) {
                                    isShowingModal = false
                                    navigateToDetail = true // Set navigation state on button tap
                                }
                            }
                        } else {
                            CustomDirectionsCard(
                                status: DirectionCardStatus.default,
                                checkpointTitle: nearestWaypoint.checkPointStatus == "summit" ? "Summit" : "Checkpoint \(nearestWaypoint.idx)",
                                etaText: "N/A",
                                altitude: Int(nearestWaypoint.elevation),
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
