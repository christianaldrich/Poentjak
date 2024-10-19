//
//  AdminEmergencyDetailView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 02/10/24.
//

import SwiftUI

import SwiftUI

struct AdminEmergencyDetailView: View {
    @StateObject var viewModel: AdminEmergencyViewModel
    @StateObject var mapViewModel: RangerMapViewModel
    @State private var showingModal = false
    var emergencyRequestId: String
    
    var body: some View {
        VStack(spacing: 20) {
            if viewModel.emergencyRequest == nil {
                Text("Loading emergency data...")
                    .foregroundColor(.gray)
            } else if let emergencyRequest = viewModel.emergencyRequest {
                
                
                RangerMapView(region: $mapViewModel.region, waypoints: mapViewModel.gpxParser.parsedWaypoints, track: mapViewModel.gpxParser.parsedTrack, showsUserLocation: true, userLastLocation: emergencyRequest.lastLocation ?? Location(latitude: 0, longitude: 0))
                
                
                Text("Emergency Type: \(emergencyRequest.emergencyType?.rawValue ?? "Not specified")")
                    .font(.headline)
                Text("Status: \(emergencyRequest.emergencyStatus.rawValue)")
                    .font(.subheadline)
                Text(emergencyRequest.user.name)
                    .font(.subheadline)
                
                
                if (emergencyRequest.assignedRangers ?? []).isEmpty {
                    Text("No rangers assigned.")
                        .foregroundColor(.red)
                    
                    Button(action: {
                        showingModal.toggle()
                    }) {
                        Text("Assign Rangers")
                    }
                    .sheet(isPresented: $showingModal) {
                        AssignRangersView(viewModel: viewModel)
                    }
                    
                } else {
                    Text("Assigned Rangers:")
                        .font(.headline)
                    ForEach(emergencyRequest.assignedRangers ?? [], id: \.self) { ranger in
                        Text(ranger)
                    }
                    
                    
                    //                    Text("Last Location: (\(emergencyRequest.lastLocation.latitude), \(emergencyRequest.lastLocation.longitude))")
                    //                        .font(.subheadline)
                    
                    Text("Last Location: (\(emergencyRequest.lastLocation?.latitude ?? 0.0), \(emergencyRequest.lastLocation?.longitude ?? 0.0))")
                        .font(.subheadline)
                    
                    Text("Track ID: \(emergencyRequest.user.trackId)")
                        .font(.subheadline)
                    
                    
                    Text("Due Date: \(emergencyRequest.dueDate, formatter: dateFormatter)")
                        .font(.subheadline)
                    
                    Button(action: {
                        Task {
                            await viewModel.evacuate(id: emergencyRequest.id)
                        }
                    }) {
                        Text("Evacuate")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.top, 16)
                    
                    Button(action: {
                        showingModal.toggle()
                    }) {
                        Text("Assign Rangers")
                    }
                    .sheet(isPresented: $showingModal) {
                        AssignRangersView(viewModel: viewModel)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            Task {
                await viewModel.loadEmergencyData(emergencyRequestId: emergencyRequestId)
            }
        }
    }
}


private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()


