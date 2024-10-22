//
//  ActionButtonSection.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 21/10/24.
//

import SwiftUI

struct ActionButtonSection: View {
    let emergencyRequest: EmergencyRequest
    @Binding var isLoading: Bool
    @ObservedObject var viewModel: AdminEmergencyViewModel
    
    var body: some View {
        VStack {
            if viewModel.selectedRangerNames.isEmpty && emergencyRequest.emergencyStatus == .danger {
                CustomPrimaryButtonComponent(state: .disabled, text: "Rescue") { }
            } else if emergencyRequest.emergencyStatus == .danger {
                CustomPrimaryButtonComponent(state: isLoading ? .loading : .enabled, text: "Rescue") {
                    startRescue()
                }
            } else {
                SlideToActionButton(slidingDirection: .ltr) {
                    Task {
                        await viewModel.evacuate(id: emergencyRequest.id)
                    }
                }
            }
        }
    }
    
    private func startRescue() {
        Task {
            isLoading = true
            if let emergencyId = viewModel.emergencyRequest?.id {
                await viewModel.assignRangers(rangerIds: viewModel.selectedRangerIds)
            }
            isLoading = false
        }
    }
}
