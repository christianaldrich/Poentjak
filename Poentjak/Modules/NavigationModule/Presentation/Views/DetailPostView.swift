//
//  DetailPostView.swift
//  Poentjak
//
//  Created by Shan Havilah on 10/10/24.
//

import SwiftUI
import CoreLocation

struct DetailPostView: View {
    @StateObject var viewModel = UserNavigateViewModel(fileName: "")
    @State var checkPointTitle: String = ""
    @State var checkPointName: String = ""
    @State var checkPointDesc: String = ""
    @State var imageName: String = ""
    @State var mdpl: Double = 0.0

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Current Checkpoint")
                    .foregroundColor(Color.primaryGreen500)
                    .font(.title1Emphasized)
                Spacer()
            }
            .padding(.leading, 30)

            // Image with rounded corners
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 340, height: 142)
                .clipped()
                .cornerRadius(16) // Apply the corner radius
            
            // Clicked Checkpoint details
            CustomLabelCheckpointDetail(checkPointTitle: checkPointTitle, checkPointName: checkPointName, checkPointDesc: checkPointDesc, mdpl: mdpl)
            
            HStack {
                Text("Directions")
                    .foregroundColor(Color.primaryGreen500)
                    .font(.title3Regular)
                    .bold()
                
                Rectangle()
                    .fill(Color.neutralGrayLightGray)
                    .frame(width: 262, height: 0.98)
                Spacer()
            }
            .padding(.top, 10)
            .padding(.leading, 30)
            
            ScrollView {
                ForEach(viewModel.gpxParser.parsedWaypoints.indices, id: \.self) { index in
                    let waypoint = viewModel.gpxParser.parsedWaypoints[index]
                    let previousWaypointName = index > 0 ? "Checkpoint \(viewModel.gpxParser.parsedWaypoints[index-1].idx)" : "Basecamp"
                    let isLastWaypoint = index == viewModel.gpxParser.parsedWaypoints.count - 1
                    let checkpointTitle = isLastWaypoint ? "Summit" : "Checkpoint \(waypoint.idx)"

                    // Calculate ETA, using the user's location for the first waypoint, otherwise use the previous waypoint's coordinates
                    if let eta = viewModel.calculateETA(
                        to: CLLocationCoordinate2D(latitude: waypoint.latitude, longitude: waypoint.longitude),
                        waypointElevation: waypoint.elevation,
                        userLocation: index == 0 ? (viewModel.locationManager.lastKnownLocation ?? CLLocationCoordinate2D()) : CLLocationCoordinate2D(latitude: viewModel.gpxParser.parsedWaypoints[index - 1].latitude, longitude: viewModel.gpxParser.parsedWaypoints[index - 1].longitude),
                        userElevation: index == 0 ? viewModel.locationManager.currentElevation : viewModel.gpxParser.parsedWaypoints[index - 1].elevation,
                        speed: viewModel.locationManager.currentSpeed
                    ) {
                        Button {
                            // Update the ViewModel's selected waypoint
                            viewModel.selectedWaypoint = waypoint
                            // Set the state variables based on the selected waypoint
                            checkPointTitle = checkpointTitle
                            checkPointName = waypoint.name
                            checkPointDesc = waypoint.desc
                            mdpl = waypoint.elevation
                            imageName = waypoint.imageName
                        } label: {
                            CustomLabelCheckpoint(labelType: waypoint.checkPointStatus == "summit" ? .summit : waypoint.checkPointStatus == "emergency" ? .emergency : .post,
                                                  checkpointTitle: checkpointTitle,
                                                  fromCheckpoint: previousWaypointName,
                                                  etaDuration: "\(String(format: "%.0f", eta))",
                                                  etaUnit: "mins",
                                                  altitude: waypoint.elevation)
                                .padding(25)
                                .background(index % 2 != 0 ? Color.neutralGrayCoolGray : Color.clear) // Set background color based on index
                        }
                    } else {
                        Button {
                            // Update the ViewModel's selected waypoint
                            viewModel.selectedWaypoint = waypoint
                            // Set the state variables based on the selected waypoint
                            checkPointTitle = checkpointTitle
                            checkPointName = waypoint.name
                            checkPointDesc = waypoint.desc
                            mdpl = waypoint.elevation
                            imageName = waypoint.imageName
                        } label: {
                            CustomLabelCheckpoint(labelType: isLastWaypoint ? .summit : .post,
                                                  checkpointTitle: checkpointTitle,
                                                  fromCheckpoint: previousWaypointName,
                                                  etaDuration: "N/A",
                                                  etaUnit: "mins",
                                                  altitude: waypoint.elevation)
                                .padding(25)
                                .background(index % 2 != 0 ? Color.neutralGrayCoolGray : Color.clear) // Set background color based on index
                        }
                    }
                }
            }
        }
        .onAppear {
            // Check if there is a selected waypoint
            if let selectedWaypoint = viewModel.selectedWaypoint {
                // Use the selected waypoint's details
                checkPointTitle = "Checkpoint \(selectedWaypoint.idx)"
                checkPointName = selectedWaypoint.name
                checkPointDesc = selectedWaypoint.desc
                mdpl = selectedWaypoint.elevation
                imageName = selectedWaypoint.imageName
            } else if let firstWaypoint = viewModel.gpxParser.parsedWaypoints.first {
                // Set initial details to the first parsed waypoint if no selection exists
                checkPointTitle = "Checkpoint \(firstWaypoint.idx)"
                checkPointName = firstWaypoint.name
                checkPointDesc = firstWaypoint.desc
                mdpl = firstWaypoint.elevation
                imageName = firstWaypoint.imageName
            }
        }
    }
}



#Preview {
    DetailPostView()
}

//                if viewModel.isSOS {
//                    // Display ETA for each waypoint warung
//                    ForEach(viewModel.gpxParser.parsedWaypointsWarung) { waypoint in
//                        if let eta = viewModel.calculateETA(to: CLLocationCoordinate2D(latitude: waypoint.latitude, longitude: waypoint.longitude), waypointElevation: waypoint.elevation, userLocation: viewModel.locationManager.lastKnownLocation ?? CLLocationCoordinate2D(), userElevation: viewModel.locationManager.currentElevation, speed: viewModel.locationManager.currentSpeed) {
//                            Text("\(waypoint.name): \(String(format: "%.1f", eta)) min")
//                                .padding()
//                        }
//                        else {
//                            Text("\(waypoint.name): N/A")
//                                .padding()
//                        }
//                    }
//                } else {
//
//                }
