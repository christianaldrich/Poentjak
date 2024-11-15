//
//  OnboardingData.swift
//  Poentjak
//
//  Created by Felicia Himawan on 29/10/24.
//

import SwiftUI

struct OnboardingData: Hashable, Identifiable {
    let id: Int
    let backgroundImage: String
    let primaryText: String
    let secondaryText: String
    
    static let sample = OnboardingData(
        id: 0, backgroundImage: "Onboarding/onboarding2",
        primaryText: "Hikewise prioritizes your safety above all else",
        secondaryText: "When tracking, hikewise provides an SOS button that will alert all nearby rangers on your track."
    )
    
    static let list: [OnboardingData] = [
        OnboardingData(id: 0, backgroundImage: "Onboarding/onboarding1", primaryText: "Hikewise prioritizes your safety above all else", secondaryText: "When tracking, hikewise provides an SOS button that will alert all nearby rangers on your track."),
        OnboardingData(id: 1, backgroundImage: "Onboarding/onboarding2", primaryText: "Assistance specific to your type of emergency", secondaryText: "Hikewise offers tailored assistance based on your situation. Whether you're dealing with hypothermia, feeling lost, or an injury."),
        OnboardingData(id: 2, backgroundImage: "Onboarding/onboarding3", primaryText: "Last seen location", secondaryText: "If you need to find signal, these blue dots signify as your last updated location in Hikewise. Rangers will also have access to this information."),
        OnboardingData(id: 3, backgroundImage: "Onboarding/onboarding4", primaryText: "Easy emergency guides", secondaryText: "We don’t want to drown you in a field of text when you’re already stressed out. Hikewise provides clear and easy to understand\nguides for you."),
        OnboardingData(id: 4, backgroundImage: "Onboarding/onboarding5", primaryText: "Partnering with local\nrangers", secondaryText: "The rangers on your track use Hikewise! If the situation escalates, don’t be scared to send the SOS to alert the nearby rangers.")
    ]
}
