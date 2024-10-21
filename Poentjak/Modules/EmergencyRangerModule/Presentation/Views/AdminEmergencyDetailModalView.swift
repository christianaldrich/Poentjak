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
                    userProfileView(emergencyRequest: emergencyRequest)
                    
                    infoRow(title: "Arrived by", value: formatDateToCustomString(date: emergencyRequest.dueDate), status: "new")
                    
                    Text("Asthma")
                    Text("Emergency Contact")
                    
                    Divider()
                        .padding(.horizontal, -24)
                    
                    vitalStatisticsView(user: emergencyRequest.user)
                    
                    Divider()
                        .padding(.horizontal, -24)
                    
                    rangersSection(emergencyRequest: emergencyRequest)
                    
                    actionButtonSection(emergencyRequest: emergencyRequest)
                }
                .padding(24)
            }
        }
    }
    
    private func userProfileView(emergencyRequest: EmergencyRequest) -> some View {
        HStack {
            Image(emergencyRequest.user.profileURL)
                .resizable()
                .clipShape(Rectangle())
                .frame(width: 85, height: 85)
                .cornerRadius(17)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("dummy")
                    Spacer()
                    Text(minutesAgo(from: emergencyRequest.dueDate))
                        .font(.caption1Regular)
                        .foregroundStyle(Color.neutralGrayTertiaryGray)
                }
                
                HStack {
                    Text(emergencyRequest.user.name)
                        .font(.headlineRegular)
                    genderIcon(gender: emergencyRequest.user.gender)
                    Spacer()
                }
            }
            .padding(.leading, 12)
        }
    }
    
    private func genderIcon(gender: String) -> some View {
        if gender == "male" {
            return Image.GenderIcon.male
        } else if gender == "female" {
            return Image.GenderIcon.female
        } else {
            return Image.GenderIcon.others
        }
    }
    
    private func infoRow(title: String, value: String, status: String) -> some View {
        HStack {
            Text("\(title) \(value)")
                .font(.footnoteRegular)
            Spacer()
            Text(status)
        }
    }
    
    private func vitalStatisticsView(user: User) -> some View {
        HStack(spacing: 40) {
            vitalStatItem(label: "Age", value: "\(user.age)", unit: "years", icon: Image.LabelIcon.age)
            vitalStatItem(label: "Height", value: "\(Int(user.height))", unit: "cm", icon: Image.LabelIcon.height)
            vitalStatItem(label: "Weight", value: "\(Int(user.weight))", unit: "kg", icon: Image.LabelIcon.weight)
        }
        .padding(.horizontal, 8)
    }
    
    private func vitalStatItem(label: String, value: String, unit: String, icon: Image) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                    .font(.calloutRegular)
                Spacer()
                icon
            }
            HStack {
                Text(value)
                    .font(.title3Emphasized)
                Text(unit)
                    .font(.customPrimaryButton)
                Spacer()
            }
        }
    }
    
    private func rangersSection(emergencyRequest: EmergencyRequest) -> some View {
        VStack(alignment: .leading) {
            Text("Rangers in rescue")
                .font(.calloutRegular)
            
            Button {
                dismiss()
                isNavigatingToAssignRangers = true
            } label: {
                rangersLabelText(emergencyRequest: emergencyRequest)
            }
        }
    }
    
    private func rangersLabelText(emergencyRequest: EmergencyRequest) -> some View {
        if !viewModel.selectedRangerNames.isEmpty && emergencyRequest.emergencyStatus == .danger {
            return Text(viewModel.selectedRangerNames.joined(separator: ", "))
                .font(.body)
        } else if let assignedRangers = emergencyRequest.assignedRangers, !assignedRangers.isEmpty && emergencyRequest.emergencyStatus == .ongoing {
            return Text(assignedRangers.joined(separator: ", "))
                .font(.body)
        } else {
            return Text("None")
        }
    }
    
    private func actionButtonSection(emergencyRequest: EmergencyRequest) -> some View {
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
