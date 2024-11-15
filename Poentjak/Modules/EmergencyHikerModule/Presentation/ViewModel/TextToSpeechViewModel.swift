//
//  TextToSpeechViewModel.swift
//  Poentjak
//
//  Created by Felicia Himawan on 08/11/24.
//

import Foundation
import AVFoundation
import SwiftUI

class TextToSpeechViewModel: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    var synthesizer = AVSpeechSynthesizer()
    @Published var isSpeaking = false
    @Published var buttonImage = Image.ButtonIcon.sound
    private var lastUtterance: AVSpeechUtterance?

    override init() {
        super.init()
        synthesizer.delegate = self
        print("TextToSpeechViewModel initialized")
    }

    func toggleSpeech(title: String, content: String) {
        if synthesizer.isSpeaking {
            stopSpeech()
        } else {
            startSpeech(title: title, content: content)
        }
    }

    func startSpeech(title: String, content: String) {
        if isSpeaking { return }

        isSpeaking = true
        buttonImage = Image.ButtonIcon.soundMute
        print("Starting speech; isSpeaking set to true")

        let titleUtterance = AVSpeechUtterance(string: title)
        titleUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        titleUtterance.rate = 0.5
        titleUtterance.pitchMultiplier = 0.8
        titleUtterance.postUtteranceDelay = 0.3
        titleUtterance.volume = 1.0

        let contentUtterance = AVSpeechUtterance(string: content)
        contentUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        contentUtterance.rate = 0.5
        contentUtterance.pitchMultiplier = 0.8
        contentUtterance.postUtteranceDelay = 0.3
        contentUtterance.volume = 1.0

        synthesizer.speak(titleUtterance)
        synthesizer.speak(contentUtterance)

        lastUtterance = contentUtterance
    }

    func stopSpeech() {
        print("Stopping speech; isSpeaking set to false")
        synthesizer.stopSpeaking(at: .immediate)
        isSpeaking = false
        buttonImage = Image.ButtonIcon.sound
    }
    

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        if utterance == lastUtterance {
            isSpeaking = false
            buttonImage = Image.ButtonIcon.sound
            print("Finished speaking last utterance; isSpeaking set to false")
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        isSpeaking = false
        buttonImage = Image.ButtonIcon.sound
        print("Speech canceled; isSpeaking set to false")
    }
    
    
}
