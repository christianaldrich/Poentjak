//
//  EmergencyTypeButtonComponent.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 14/10/24.
//

import SwiftUI

enum EmergencyTypeButton {
    case hypothermia
    case lost
    case injury

    var iconName: Image {
        switch self {
        case .hypothermia:
            return Image.LabelIcon.hypothermia
        case .lost:
            return Image.LabelIcon.lost
        case .injury:
            return Image.LabelIcon.injured
        }
    }

    var title: String {
        switch self {
        case .hypothermia:
            return "Hypothermia"
        case .lost:
            return "Lost"
        case .injury:
            return "Injury"
        }
    }
}

struct EmergencyButtonComponent: View {
    var emergencyType: EmergencyTypeButton
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 54, height: 54)
                    .foregroundStyle(Color.accentRedSos)
                    .overlay {
                        emergencyType.iconName
                    }
                    .padding(.trailing, 40) // Add padding to the right of the icon

                Text(emergencyType.title)
                    .font(.title3Regular)
                    .foregroundColor(Color.neutralBlack)

                Spacer() // This keeps the spacing flexible
            }
            .padding(.leading, 8) // Add left padding to the whole HStack
            .frame(width: 340, height: 64)
            .background(Color.neutralWhite)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)

        }
    }
}

#Preview {
    VStack {
        EmergencyButtonComponent(emergencyType: .hypothermia) {
            print("Hypothermia action triggered")
        }
        EmergencyButtonComponent(emergencyType: .lost) {
            print("Lost action triggered")
        }
        EmergencyButtonComponent(emergencyType: .injury) {
            print("Injury action triggered")
        }
    }
}
