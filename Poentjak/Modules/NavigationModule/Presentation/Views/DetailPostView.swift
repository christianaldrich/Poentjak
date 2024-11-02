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
    @State var mdpl: Double = 0.0
    
    var body: some View {
        VStack (alignment: .center){
            
            HStack {
                Text("Checkpoints")
                    .foregroundColor(Color.primaryGreen500)
                    .font(.title1Emphasized)
                Spacer()
            }
            .padding(.leading, 30)
            
            // Image with rounded corners
            Image("profPic") // Replace with your image name
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
                Spacer()
            }
            .padding(.leading, 30)
            
            ScrollView{
                
                if viewModel.isSOS {
                    // Display ETA for each waypoint warung
                    ForEach(viewModel.gpxParser.parsedWaypointsWarung) { waypoint in
                        if let eta = viewModel.calculateETA(to: CLLocationCoordinate2D(latitude: waypoint.latitude, longitude: waypoint.longitude), waypointElevation: waypoint.elevation, userLocation: viewModel.locationManager.lastKnownLocation ?? CLLocationCoordinate2D(), userElevation: viewModel.locationManager.currentElevation, speed: viewModel.locationManager.currentSpeed) {
                            Text("\(waypoint.name): \(String(format: "%.1f", eta)) min")
                                .padding()
                        }
                        else {
                            Text("\(waypoint.name): N/A")
                                .padding()
                        }
                    }
                } else {
                    // Display ETA for each waypoint pos
                    ForEach(viewModel.gpxParser.parsedWaypointsPos) { waypoint in
                        if let eta = viewModel.calculateETA(to: CLLocationCoordinate2D(latitude: waypoint.latitude, longitude: waypoint.longitude), waypointElevation: waypoint.elevation, userLocation: viewModel.locationManager.lastKnownLocation ?? CLLocationCoordinate2D(), userElevation: viewModel.locationManager.currentElevation, speed: viewModel.locationManager.currentSpeed) {
                            Text("\(waypoint.name): \(String(format: "%.1f", eta)) min")
                                .padding()
                        }
                        else {
                            CustomLabelCheckpoint(checkpointTitle: waypoint.name, fromCheckpoint: waypoint.name, etaDuration: "N/A", etaUnit: "mins", altitude: waypoint.elevation)
                                .onTapGesture {
                                    checkPointTitle = waypoint.name
                                    checkPointName = waypoint.name
                                    checkPointDesc = waypoint.desc
                                    mdpl = waypoint.elevation
                                }
                        }
                    }
                }
            }
            .padding(.leading, 25)
        }
    }
}

#Preview {
    DetailPostView()
}
