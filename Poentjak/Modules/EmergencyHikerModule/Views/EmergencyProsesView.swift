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
        
        VStack (alignment: .center){
            
//            Button("Top View"){
//                
//            }
            
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
                Text("No more waypoints.")
                    .padding()
            }
            
            UserNavigateView(viewModel: navigateViewModel)
//                .frame(width: 700, height: 700)
            
//            Text("This is hiking session")
//            
//            Text(viewModel.status)
//                .padding()
//            Text(viewModel.userName)
//                .padding()
//            Text("\(viewModel.dueDate)")
//                .padding()
//            Text("\(viewModel.sessionId)")
//                .padding()
            

            
            Text("edit time")
            
            Text("SOS")
            
//            Text("I am back at basecamp")
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
            
//            Button("Delete Emergency") {
//                Task {
//                    await viewModel.deleteEmergency()
//                    presentationMode.wrappedValue.dismiss()
//                }
//            }
//            .buttonStyle(PlainButtonStyle())
//            .padding()
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
