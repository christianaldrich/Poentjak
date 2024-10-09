//
//  StatsView.swift
//  MacroSprint_1
//
//  Created by Shan Havilah on 03/10/24.
//

import SwiftUI
import CoreLocation

struct StatsView: View {
    
    @StateObject var viewModel = StatsViewModel()
    
    var body: some View {
        // On-track or off-track indicator
        Text(viewModel.isOnTrack ? "You are on Track" : "Your are Off Track")
            .foregroundColor(viewModel.isOnTrack ? .green : .red)
            .font(.headline)
            .padding()
        
        // Display elapsed time
        Text(String(format: "%02d:%02d:%02d", Int(viewModel.elapsedTime) / 3600, (Int(viewModel.elapsedTime) % 3600) / 60, Int(viewModel.elapsedTime) % 60))
            .font(.headline)
            .padding()
        
        // Display ETA for each waypoint
        ForEach(viewModel.gpxParser.parsedWaypoints) { waypoint in
            if let eta = viewModel.calculateETA(to: CLLocationCoordinate2D(latitude: waypoint.latitude, longitude: waypoint.longitude), waypointElevation: waypoint.elevation, userLocation: viewModel.locationManager.lastKnownLocation ?? CLLocationCoordinate2D(), userElevation: viewModel.locationManager.currentElevation, speed: viewModel.locationManager.currentSpeed) {
                Text("\(waypoint.name): ETA \(String(format: "%.1f", eta)) min")
            }
            else {
                Text("\(waypoint.name): ETA unavailable (no speed)")
                    .padding()
            }
        }
    }
}

#Preview {
    StatsView()
}
