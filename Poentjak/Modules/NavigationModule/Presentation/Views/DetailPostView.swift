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
        // Display ETA for each waypoint
        ForEach(viewModel.gpxParser.parsedWaypoints) { waypoint in
            if let eta = viewModel.calculateETA(to: CLLocationCoordinate2D(latitude: waypoint.latitude, longitude: waypoint.longitude), waypointElevation: waypoint.elevation, userLocation: viewModel.locationManager.lastKnownLocation ?? CLLocationCoordinate2D(), userElevation: viewModel.locationManager.currentElevation, speed: viewModel.locationManager.currentSpeed) {
                Text("\(waypoint.name): \(String(format: "%.1f", eta)) min")
            }
            else {
                Text("\(waypoint.name): N/A")
                    .padding()
            }
        }
        
        Button("I am back at basecamp"){
            Task{
//                await viewModel.updateSessionDone()
                viewModel.isNavigating = false
                viewModel.stopTimer()
                viewModel.locationManager.resetTotalDistance()
                
//                    print("\(viewModel.sessionId)")
//                               presentationMode.wrappedValue.dismiss()
                       
            }
        }
    }
}

#Preview {
    DetailPostView()
}
