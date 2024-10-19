//
//  CustomLabelStatus.swift
//  Poentjak
//
//  Created by Felicia Himawan on 17/10/24.
//
import SwiftUI

struct CustomLabelStatus: View {
    enum StatusType {
        case inRescue
        case arrived
        case redHours(remainingTime: String)
        case yellowHours(remainingTime: String)
        case greenHours(remainingTime: String)
        case iconOnly
        case iconAndText
        
        var text: String {
            switch self {
            case .inRescue: return "In rescue"
            case .arrived: return "ARRIVED"
            case .redHours(let remainingTime): return "\(remainingTime) LEFT"
            case .yellowHours(let remainingTime): return "\(remainingTime) LEFT"
            case .greenHours(let remainingTime): return "\(remainingTime) LEFT"
            case .iconOnly: return ""
            case .iconAndText: return "Contact"
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .inRescue: return Color.secondaryYellow
            case .arrived: return Color.accentGreenlabelpositive
            case .redHours: return Color.accentRedBgLabel
            case .yellowHours: return Color.secondaryYellowLabelBackground
            case .greenHours: return Color.accentGreenlabel
            case .iconOnly, .iconAndText: return Color.neutralWhiteBiancaWhite
            }
        }
        
        var textColor: Color {
            switch self {
            case .inRescue: return Color.secondaryYellowText
            case .arrived: return Color.white
            case .redHours: return Color.errorRed500
            case .yellowHours: return Color.secondaryYellowText
            case .greenHours: return Color.accentGreenText
            case .iconOnly, .iconAndText: return Color.primaryGreen500
            }
        }
        
        var icon: Image? {
            switch self {
            case .iconOnly: return Image(systemName: "person.crop.square.fill")
            case .iconAndText: return Image(systemName: "person.crop.square.fill")
            default: return nil
            }
        }
    }
    
    let type: StatusType
    
    var body: some View {
        HStack {
            if let icon = type.icon {
                icon
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(Color.primaryGreen500)
            }
            if !type.text.isEmpty {
                Text(type.text)
                    .font(.footnoteEmphasizedBold)
                    .foregroundColor(type.textColor)
            }
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background(type.backgroundColor)
        .cornerRadius(8)
    }
}

#Preview {
    VStack(spacing: 10) {
        CustomLabelStatus(type: .inRescue)
        CustomLabelStatus(type: .arrived)
        CustomLabelStatus(type: .redHours(remainingTime: "1 HR"))
        CustomLabelStatus(type: .yellowHours(remainingTime: "3 HRS"))
        CustomLabelStatus(type: .greenHours(remainingTime: "7 HRS"))
        CustomLabelStatus(type: .iconOnly)
        CustomLabelStatus(type: .iconAndText)
    }
    .padding()
}
