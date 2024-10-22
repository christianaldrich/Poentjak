//
//  UserProfileView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 21/10/24.
//

import Foundation
import SwiftUI

struct UserProfileView: View {
    let emergencyRequest: EmergencyRequest
    
    var body: some View {
        HStack {
            Image(emergencyRequest.user.profileURL)
                .resizable()
                .clipShape(Rectangle())
                .frame(width: 85, height: 85)
                .cornerRadius(17)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    switch emergencyRequest.emergencyType {
                    case .hipo:
                        CustomLabelEmergencyType(type: .hypothermia)
                    case .injury:
                        CustomLabelEmergencyType(type: .injury)
                    case .lost:
                        CustomLabelEmergencyType(type: .lost)
                    case .overdue:
                        CustomLabelEmergencyType(type: .overdue)
                    case .none:
                        CustomLabelEmergencyType(type: .overdue)
                    }
                    
                    Spacer()
                    Text(minutesAgo(from: emergencyRequest.dueDate))
                        .font(.caption1Regular)
                        .foregroundStyle(Color.neutralGrayTertiaryGray)
                }
                
                HStack {
                    Text(emergencyRequest.user.name)
                        .font(.headlineRegular)
                    switch emergencyRequest.user.gender{
                    case "Male": //nanti ganti male
                        Image.GenderIcon.male
                    case "Female": // nanti ganti female
                        Image.GenderIcon.female
                    default:
                        Image.GenderIcon.others
                    }
                    Spacer()
                }
            }
            .padding(.leading, 12)
        }
    }
}
