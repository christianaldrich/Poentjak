//
//  DetailPostView.swift
//  Poentjak
//
//  Created by Shan Havilah on 10/10/24.
//

import SwiftUI
import CoreLocation

struct DetailPostView: View {
    @StateObject var viewModel = UserNavigateViewModel()
    var body: some View {
        
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
                    Text("\(waypoint.name): N/A")
                        .padding()
                }
            }
        }
    }
}

#Preview {
    DetailPostView()
}
