//
//  GenderButtonComponent.swift
//  Poentjak
//
//  Created by Shan Havilah on 19/10/24.
//

import SwiftUI

enum GenderButton {
    case female
    case male
    case others

    var iconName: Image {
        switch self {
        case .female:
            return Image.GenderIcon.female
        case .male:
            return Image.GenderIcon.male
        case .others:
            return Image.GenderIcon.others
        }
    }

    var title: String {
        switch self {
        case .female:
            return "Female"
        case .male:
            return "Male"
        case .others:
            return "Others"
        }
    }
}

struct GenderButtonComponent: View {
    var genderType: GenderButton
    //var action: () -> Void
    var state: ButtonState = .enabled
    
    var body: some View {
        Button {
            if state == .enabled {
                //action()
            }
        } label: {
            ZStack {
                Rectangle()
                    .fill(backgroundColorButton(for: state))
                    .cornerRadius(16)
                
                HStack {
                    genderType.iconName
                        .renderingMode(.template) // This allows the icon to be tinted
                        .foregroundColor(foregroundColorButton(for: state))
                        .padding(.trailing, 13)
                    
                    Text(genderType.title)
                        .foregroundColor(foregroundColorButton(for: state))
                        .font(.headlineRegular)
                    
                    Spacer()
                }
                .padding(.leading, 18)
            }
            .frame(width: 340, height: 60)
        }
    }
}

#Preview {
    GenderButtonComponent(genderType: .female)
    GenderButtonComponent(genderType: .female, state: .secondary)
}
