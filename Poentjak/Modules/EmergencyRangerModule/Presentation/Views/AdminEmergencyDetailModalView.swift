//
//  AdminEmergencyDetailModalView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 19/10/24.
//

import SwiftUI

struct AdminEmergencyDetailModalView: View {
    @StateObject var viewModel: AdminEmergencyViewModel
    @Binding var isNavigatingToAssignRangers: Bool
    @State private var isLoading: Bool = false
    @Environment(\.dismiss) var dismiss
    
    let currentDate = Date()
    
    var body: some View {
        ScrollView {
            if let emergencyRequest = viewModel.emergencyRequest {
                VStack(spacing: 16) {
                    UserProfileView(emergencyRequest: emergencyRequest)
                        .padding(.horizontal, 12)
                    
                    InfoRowView(title: "Arrived by", value: formatDateToCustomString(date: emergencyRequest.dueDate), emergencyRequest: emergencyRequest )
                        .padding(.horizontal, 12)
                    
                    CustomLongRectangleDetail(type: .note(text: emergencyRequest.user.medicalRecord ?? "None"))
                    
                    EmergencyContactButton(value: emergencyRequest.user.contactName) {
                        
                    }
                        
                    Divider().padding(.horizontal, -24)
                    
                    VitalStatisticsView(user: emergencyRequest.user)
                        .padding(.horizontal, 12)
                    
                    Divider().padding(.horizontal, -24)
                    
                    RangersSection(emergencyRequest: emergencyRequest, dismiss: dismiss, isNavigatingToAssignRangers: $isNavigatingToAssignRangers, viewModel: viewModel)
                    
                    ActionButtonSection(emergencyRequest: emergencyRequest, isLoading: $isLoading, viewModel: viewModel)
                }
                .padding(24)
            }
        }
    }
}
