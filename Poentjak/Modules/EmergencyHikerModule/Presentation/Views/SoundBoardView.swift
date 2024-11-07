//
//  SoundBoardView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 17/10/24.
//

import SwiftUI
import AVFoundation
import AudioToolbox

struct SoundBoardView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var activeSound: SoundBoardButton? = nil // Track active sound button
    @State private var timer: Timer? // Shared timer for looping sound
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Soundboard")
                .font(.title1Emphasized)
                .foregroundStyle(Color.primaryGreen500)
            
            VStack {
                HStack {
                    SoundBoardButtonComponent(
                        soundBoardType: .airhorn,
                        activeSound: $activeSound,
                        currentActiveSound: .airhorn,
                        timer: $timer
                    )
                    SoundBoardButtonComponent(
                        soundBoardType: .whistle,
                        activeSound: $activeSound,
                        currentActiveSound: .whistle,
                        timer: $timer
                    )
                }
                
                HStack {
                    SoundBoardButtonComponent(
                        soundBoardType: .siren,
                        activeSound: $activeSound,
                        currentActiveSound: .siren,
                        timer: $timer
                    )
                    SoundBoardButtonComponent(
                        soundBoardType: .morse,
                        activeSound: $activeSound,
                        currentActiveSound: .morse,
                        timer: $timer
                    )
                }
            }
            
            VStack {
                
                
                
                Text("Use the soundboard in emergencies to ")
                    .font(.calloutRegular)
                    .foregroundColor(.primaryGreen500) +
                Text("alert rangers and nearby hikers")
                    .font(.calloutEmphasized)
                    .foregroundColor(.primaryGreen500)
                    
            }
            .padding(.top, 24)
            .padding(.horizontal, 0)
            
            Text("Tap on a distress sound and stay visible while waiting for help.")
                .font(.calloutRegular)
                .foregroundColor(.primaryGreen500)
                .padding(.top, 16)
            
            
            
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
    }
}



#Preview {
    SoundBoardView()
        .environmentObject(NavigationManager())
}
