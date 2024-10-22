//
//  RangersSection.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 21/10/24.
//

import Foundation
import SwiftUI

struct RangersSection: View {
    let emergencyRequest: EmergencyRequest
    let dismiss: DismissAction
    @Binding var isNavigatingToAssignRangers: Bool
    @ObservedObject var viewModel: AdminEmergencyViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Rangers in rescue")
                .font(.calloutRegular)
            
            CustomLongRectanglePicker(
                assignedRangers: assignedRangerNames(emergencyRequest: emergencyRequest),
                action: {
                    dismiss()
                    isNavigatingToAssignRangers = true
                }
            )
        }
    }
    
    // Helper function to determine assigned ranger names
    private func assignedRangerNames(emergencyRequest: EmergencyRequest) -> [String] {
        if !viewModel.selectedRangerNames.isEmpty && emergencyRequest.emergencyStatus == .danger {
            return viewModel.selectedRangerNames
        } else if let assignedRangers = emergencyRequest.assignedRangers, !assignedRangers.isEmpty{
            return assignedRangers
        } else {
            return []
        }
    }
}

