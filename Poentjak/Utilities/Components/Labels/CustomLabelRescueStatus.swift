//
//  CustomLabelRescueStatus.swift
//  Poentjak
//
//  Created by Felicia Himawan on 17/10/24.
//

import SwiftUI

struct CustomLabelRescueStatus: View {
    enum Status {
        case complete, ongoing, new
        
        var text: String {
            switch self {
            case .complete: return "Completed"
            case .ongoing: return "Ongoing"
            case .new: return "New"
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .complete: return Color.customLabelsReminderBgGreen
            case .ongoing: return Color.customLabelsReminderBgYellow
            case .new: return Color.customLabelsReminderBgRed
            }
        }
        
        var textColor: Color {
            switch self {
            case .complete: return Color.customLabelsReminderIconGreen
            case .ongoing: return Color.customLabelsEmergencyYellow
            case .new: return Color.errorRed500
            }
        }
    }
    
    let status: Status
    
    var body: some View {
        HStack{
            Text(status.text)                .foregroundColor(status.textColor)
                .font(.labelCaption1Emphasized)
        }
        .padding(6)
        .background(status.backgroundColor)
        .cornerRadius(4)
       
    }
}

#Preview {
    VStack(spacing: 10) {
        CustomLabelRescueStatus(status: .complete)
        CustomLabelRescueStatus(status: .ongoing)
        CustomLabelRescueStatus(status: .new)
    }
    .padding()
}
