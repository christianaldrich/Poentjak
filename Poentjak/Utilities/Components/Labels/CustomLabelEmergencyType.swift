//
//  CustomLabelEmergencyType.swift
//  Poentjak
//
//  Created by Felicia Himawan on 17/10/24.
//

import SwiftUI

struct CustomLabelEmergencyType: View {
    
    enum EmergencyType {
        case hypothermia, lost, injury, overdue
        
        var text: String {
            switch self {
            case .hypothermia: return "Hypothermia"
            case .lost: return "Lost"
            case .injury: return "Injury"
            case .overdue: return "Overdue"
            }
        }
        
        var icon: AnyView {
            switch self {
            case .hypothermia:
                return AnyView(
                    Image.LabelIcon.hypothermia
                        .resizable()
                        .frame(width: 16, height: 16)
                )
                
            case .lost:
                return AnyView(
                    Image.LabelIcon.lost
                        .resizable()
                        .frame(width: 13, height: 16)
                )
                
            case .injury:
                return AnyView(
                    Image.LabelIcon.injured
                        .resizable()
                        .frame(width: 16, height: 16)
                )
                
            case .overdue:
                return AnyView(
                    Image(systemName: "clock.badge.exclamationmark")
                        .resizable()
                        .frame(width: 18, height: 16)
                        .fontWeight(.bold)
                )
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .hypothermia: return Color.customLabelsEmergencyOrange
            case .lost: return Color.customLabelsEmergencyRed
            case .injury: return Color.customLabelsEmergencyDarkYellow
            case .overdue: return Color.customLabelsEmergencyYellow
            }
        }
    }
    
    let type: EmergencyType
    
    var body: some View {
        HStack(spacing: 4) {
            type.icon
                .foregroundStyle(Color.white)
            
            Text(type.text)
                .font(.footnoteEmphasizedBold)
                .foregroundStyle(Color.white)
        }
        .padding(10)
        .background(type.backgroundColor)
        .cornerRadius(8)
    }
}

#Preview {
    VStack(spacing: 10) {
        CustomLabelEmergencyType(type: .hypothermia)
        CustomLabelEmergencyType(type: .lost)
        CustomLabelEmergencyType(type: .injury)
        CustomLabelEmergencyType(type: .overdue)
    }
    .padding()
}
