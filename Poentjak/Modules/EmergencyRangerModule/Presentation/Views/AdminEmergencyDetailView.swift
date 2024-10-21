//
//  AdminEmergencyDetailView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 02/10/24.
//

//
//  AdminEmergencyDetailView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 02/10/24.
//

import SwiftUI

struct AdminEmergencyDetailView: View {
    @StateObject var viewModel: AdminEmergencyViewModel
    @StateObject var mapViewModel: RangerMapViewModel
    var emergencyRequestId: String
    @State private var isShowingModal = true
    @State private var selectedDetent = PresentationDetent.fraction(0.7)
    @State private var isNavigatingToAssignRangers = false
    
    var body: some View {
        
        VStack {
            if viewModel.emergencyRequest == nil {
                Text("Loading emergency data...")
                    .foregroundColor(.gray)
            } else if let emergencyRequest = viewModel.emergencyRequest {
                GeometryReader { geometry in
                    RangerMapView(region: $mapViewModel.region, waypoints: mapViewModel.gpxParser.parsedWaypoints, track: mapViewModel.gpxParser.parsedTrack, showsUserLocation: true, userLastLocation: emergencyRequest.lastLocation ?? Location(latitude: 0, longitude: 0))
                        .frame(height: geometry.size.height * 0.9)
                        .edgesIgnoringSafeArea(.all)
                }
                .sheet(isPresented: $isShowingModal) {
                    AdminEmergencyDetailModalView(viewModel: viewModel, isNavigatingToAssignRangers: $isNavigatingToAssignRangers)
                        .presentationDetents([.fraction(0.7), .fraction(0.4)], selection: $selectedDetent)
                        .presentationDragIndicator(.visible)
                        .presentationBackgroundInteraction(
                            .enabled(upThrough: .fraction(0.7))
                        )
                        .interactiveDismissDisabled(true)
                }
                .background(
                    NavigationLink(destination: AssignRangersView(viewModel: viewModel),
                                   isActive: $isNavigatingToAssignRangers) {
                                       EmptyView()
                                   }
                        .hidden()
                )
            }
        }
        .onAppear {
            Task {
                await viewModel.loadEmergencyData(emergencyRequestId: emergencyRequestId)
            }
            isShowingModal = true
        }
        
    }
    
}


