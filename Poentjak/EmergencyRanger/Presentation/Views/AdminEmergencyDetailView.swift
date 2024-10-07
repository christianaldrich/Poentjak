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
    @State private var showingModal = false
    let emergencyRequestId: String
    
    var body: some View {
        VStack(spacing: 20) {
            if viewModel.emergencyRequest == nil {
                Text("Loading emergency data...")
                    .foregroundColor(.gray)
            } else if let emergencyRequest = viewModel.emergencyRequest {
                
                Text("Emergency Type: \(emergencyRequest.emergencyType.rawValue)")
                    .font(.headline)
                Text("Status: \(emergencyRequest.emergencyStatus.rawValue)")
                    .font(.subheadline)
                Text(emergencyRequest.user.name)
                    .font(.subheadline)
                
                
                if emergencyRequest.assignedRangers.isEmpty {
                    Text("No rangers assigned.")
                        .foregroundColor(.red)
                } else {
                    Text("Assigned Rangers:")
                        .font(.headline)
                    ForEach(emergencyRequest.assignedRangers, id: \.self) { ranger in
                        Text(ranger)
                    }
                    
                    
                    Text("Last Location: (\(emergencyRequest.lastLocation.latitude), \(emergencyRequest.lastLocation.longitude))")
                        .font(.subheadline)
                    
                    
                    Text("Track ID: \(emergencyRequest.user.trackId)")
                        .font(.subheadline)
                    
                    
                    Text("Due Date: \(emergencyRequest.dueDate, formatter: dateFormatter)")
                        .font(.subheadline)
                    
                    
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


