//
//  SoundBoardButtonComponent.swift
//  Poentjak
//
//  Created by Shan Havilah on 19/10/24.
//

import SwiftUI

enum SoundBoardButton {
    case airhorn
    case whistle
    case siren
    case morse

    var iconName: Image {
        switch self {
        case .airhorn:
            return Image.SoundBoardIcon.airhorn
        case .whistle:
            return Image.SoundBoardIcon.whistle
        case .siren:
            return Image.SoundBoardIcon.alarm
        case .morse:
            return Image.SoundBoardIcon.sosMorse
        }
    }

    var title: String {
        switch self {
        case .airhorn:
            return "Airhorn"
        case .whistle:
            return "Whistle"
        case .siren:
            return "Siren"
        case .morse:
            return "SOS Morse"
        }
    }
}

struct SoundBoardButtonComponent: View {
    var soundBoardType: SoundBoardButton
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
                
                VStack {
                    soundBoardType.iconName
                        .renderingMode(.template) // This allows the icon to be tinted
                        .foregroundColor(foregroundColorButton(for: state))
                    
                    Text(soundBoardType.title)
                        .foregroundColor(foregroundColorButton(for: state))
                        .font(.title3Emphasized)
                    
                }
                
            }
            .frame(width: 170, height: 159)
        }
    }
}

#Preview {
    SoundBoardButtonComponent(soundBoardType: .airhorn)
    SoundBoardButtonComponent(soundBoardType: .whistle)
    SoundBoardButtonComponent(soundBoardType: .siren)
    SoundBoardButtonComponent(soundBoardType: .morse)
}
