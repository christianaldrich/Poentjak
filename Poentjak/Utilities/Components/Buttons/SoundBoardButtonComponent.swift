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
    
    var fileName: String {
            switch self {
            case .airhorn: return "airhorn_sound"
            case .whistle: return "whistle_sound"
            case .siren: return "siren_sound"
            case .morse: return "morse_sound"
            }
        }
}

struct SoundBoardButtonComponent: View {
    var soundBoardType: SoundBoardButton
    @Binding var activeSound: SoundBoardButton? // Track which button is active
    var currentActiveSound: SoundBoardButton // Identifier for this button
    @Binding var audioPlayer: AVAudioPlayer? // Shared AVAudioPlayer for sound playback

    var body: some View {
        Button {
            if activeSound == currentActiveSound {
                stopPlayingSound()
                activeSound = nil
            } else {
                stopAllSounds()
                activeSound = currentActiveSound
                startPlayingSound()
            }
        } label: {
            ZStack {
                Rectangle()
                    .fill(activeSound == currentActiveSound ? Color.primaryGreen500 : Color.white)
                    .cornerRadius(16)
                    .customShadow()
                
                VStack {
                    soundBoardType.iconName
                        .renderingMode(.template)
                        .foregroundColor(activeSound == currentActiveSound ? .white : Color.primaryGreen500)
                        .frame(width: 50, height: 50)
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    Text(soundBoardType.title)
                        .foregroundColor(activeSound == currentActiveSound ? .white : Color.primaryGreen500)
                        .font(.title3Emphasized)
                        .padding(.bottom, 21)
                }
                
            }
            .frame(width: 170, height: 159)
        }
        .onDisappear {
            stopAllSounds() // Stop all sounds when view disappears (when navigating away)
        }
    }
    
    func startPlayingSound() {
        guard let soundURL = Bundle.main.url(forResource: soundBoardType.fileName, withExtension: "mp3") else {
            print("Sound file not found: \(soundBoardType.fileName).mp3")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.numberOfLoops = -1 // Infinite loop
            audioPlayer?.play()
        } catch {
            print("Failed to play sound: \(error.localizedDescription)")
        }
    }
    
    func stopPlayingSound() {
        audioPlayer?.stop()
        audioPlayer = nil
    }

    func stopAllSounds() {
        if let player = audioPlayer {
            player.stop()
            audioPlayer = nil
        }
    }
}
