//
//  SoundBoardButtonComponent.swift
//  Poentjak
//
//  Created by Shan Havilah on 19/10/24.
//

import SwiftUI
import AVFoundation
import AudioToolbox

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
    
    var soundID: SystemSoundID {
        switch self {
        case .airhorn: return 1023
        case .whistle: return 1024
        case .siren: return 1025
        case .morse: return 1026
        }
    }
}

struct SoundBoardButtonComponent: View {
    var soundBoardType: SoundBoardButton
    @Binding var activeSound: SoundBoardButton? // Track which button is active
    var currentActiveSound: SoundBoardButton // Identifier for this button
    @Binding var timer: Timer? // Shared timer for sound loop
    
    var body: some View {
        Button {
            if activeSound == currentActiveSound {
                stopLoopingSound()
                activeSound = nil
            } else {
                stopAllSounds()
                activeSound = currentActiveSound
                startLoopingSound()
            }
        } label: {
            ZStack {
                Rectangle()
                    .fill(activeSound == currentActiveSound ? Color.primaryGreen500 : Color.white)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2) // Shadow effect
                
                VStack {
                    soundBoardType.iconName
                        .renderingMode(.template)
                        .foregroundColor(activeSound == currentActiveSound ? .white : Color.primaryGreen500)
                        .frame(width: 50, height: 50)
                    
                    Text(soundBoardType.title)
                        .foregroundColor(activeSound == currentActiveSound ? .white : Color.primaryGreen500)
                        .font(.title3Emphasized)
                }
                
            }
            .frame(width: 170, height: 159)
        }
        .onDisappear {
            stopAllSounds() // Stop all sounds when view disappears (when navigating away)
        }
    }
    
    func startLoopingSound() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            AudioServicesPlaySystemSound(soundBoardType.soundID)
        }
    }
    
    func stopLoopingSound() {
        timer?.invalidate()
        timer = nil
    }

    func stopAllSounds() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
    }
}
