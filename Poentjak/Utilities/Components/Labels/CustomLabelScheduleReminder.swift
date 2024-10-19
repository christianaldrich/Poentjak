//
//  CustomLabelScheduleReminder.swift
//  Poentjak
//
//  Created by Felicia Himawan on 17/10/24.
//

import SwiftUI

struct CustomLabelScheduleReminder: View {
    enum ReminderType {
        case green, yellow, red
        
        var iconColor: Color {
            switch self {
            case .green: return Color.customLabelsReminderIconGreen
            case .yellow: return Color.customLabelsReminderIconYellow
            case .red: return Color.customLabelsReminderIconRed
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .green: return Color.customLabelsReminderBgGreen
            case .yellow: return Color.customLabelsReminderBgYellow
            case .red: return Color.customLabelsReminderBgRed
            }
        }
        
        var textColor: Color {
            switch self {
            case .green: return Color.accentGreenText
            case .yellow: return Color.secondaryYellowText
            case .red: return Color.customLabelsReminderTextRed
            }
        }
        
        var timeText: String {
            switch self {
            case .green: return "10 minutes"
            case .yellow: return "5 hours"
            case .red: return "1 hours"
            }
        }
    }
    
    let type: ReminderType
    let remainingTime: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "clock.badge.exclamationmark.fill")
                .resizable()
                .foregroundColor(type.iconColor)
                .frame(width: 28, height: 24)
            
            Text(remainingTime)
                .font(.subheadlineEmphasized)
                .foregroundColor(type.textColor) +
            Text(" left from schedule")
                .font(.subheadlineRegular)
                .foregroundColor(type.textColor)
            
            Spacer()
            
        }
        .padding(.vertical, 24)
        .padding(.leading, 16)
        //        .padding(.trailing, 92)
        .background(type.backgroundColor)
        .cornerRadius(8)
    }
}

#Preview {
    VStack(spacing: 10) {
        CustomLabelScheduleReminder(type: .green, remainingTime: "5 hours")
        CustomLabelScheduleReminder(type: .yellow, remainingTime: "1 hour")
        CustomLabelScheduleReminder(type: .red, remainingTime: "10 minutes")
    }
    .padding()
}

