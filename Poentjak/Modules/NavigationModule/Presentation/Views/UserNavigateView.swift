//
//  ContentView.swift
//  MacroSprint_1
//
//  Created by Shan Havilah on 29/09/24.
//

import SwiftUI
import CoreLocation

struct UserNavigateView: View {
    @StateObject var viewModel = UserNavigateViewModel()
    
    var body: some View {
        VStack {
            // Show the map with GPX waypoints
            MapView(region: $viewModel.region, waypoints: viewModel.gpxParser.parsedWaypoints, track: viewModel.gpxParser.parsedTrack, showsUserLocation: true, dots: viewModel.dots)
                
//                // Display ETA for each waypoint
//                ForEach(viewModel.gpxParser.parsedWaypoints) { waypoint in
//                    if let eta = viewModel.calculateETA(to: CLLocationCoordinate2D(latitude: waypoint.latitude, longitude: waypoint.longitude), waypointElevation: waypoint.elevation, userLocation: viewModel.locationManager.lastKnownLocation ?? CLLocationCoordinate2D(), userElevation: viewModel.locationManager.currentElevation, speed: viewModel.locationManager.currentSpeed) {
//                        Text("\(waypoint.name): \(String(format: "%.1f", eta)) min")
//                    }
//                    else {
//                        Text("\(waypoint.name): N/A")
//                            .padding()
//                    }
//                }
        }
        .onAppear {
            viewModel.setupRegionUser()
        }
    }
}

#Preview {
    UserNavigateView()
}
