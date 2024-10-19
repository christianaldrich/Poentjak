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
    @State private var isLooping: Bool = false
    @State private var timer: Timer?
    
    var body: some View {
        VStack{
            Text("This is sound board view")
            
            Button(action: {
                AudioServicesPlaySystemSound(1333) // Play system sound once
            }) {
                Text("Play Sound Once")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            Button(action: {
                toggleLoopSound()
            }) {
                Text(isLooping ? "Stop Sound" : "Play Sound Continuously")
                    .padding()
                    .background(isLooping ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            
        }
    }
    
    func toggleLoopSound() {
            if isLooping {
                stopLoopingSound()
            } else {
                startLoopingSound()
            }
            isLooping.toggle()
        }

        // Start looping the system sound using a timer
        func startLoopingSound() {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                AudioServicesPlaySystemSound(1026)
            }
        }

        // Stop the looping sound
        func stopLoopingSound() {
            timer?.invalidate() // Stop the timer
            timer = nil
        }
}

#Preview {
    SoundBoardView()
        .environmentObject(NavigationManager())
}
