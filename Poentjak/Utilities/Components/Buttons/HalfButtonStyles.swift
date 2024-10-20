//
//  HalfButtonStyles.swift
//  Poentjak
//
//  Created by Shan Havilah on 19/10/24.
//

import SwiftUI

enum HalfButton {
    case primaryGuide
    case SOS
    case SOSSending
    case SOSSent
    case secondaryGuide

    var iconName: Image? {
        switch self {
        case .primaryGuide, .secondaryGuide:
            return Image.ButtonIcon.guide
        case .SOS:
            return Image.ButtonIcon.sos
        case .SOSSending:
            return nil
        case .SOSSent:
            return nil
        }
    }

    var title: String {
        switch self {
        case .primaryGuide, .secondaryGuide:
            return "Guide"
        case .SOS:
            return "SOS"
        case .SOSSending:
            return "SOS Sending"
        case .SOSSent:
            return "SOS Sent"
        }
    }
}

func foregroundColorButton(for state: HalfButton) -> Color {
    switch state {
    case .primaryGuide, .SOS, .SOSSent, .SOSSending:
        return Color.neutralWhite
    case .secondaryGuide:
        return Color.primaryGreen500
    }
}

func backgroundColorButton(for state: HalfButton) -> Color {
    switch state {
    case .primaryGuide:
        return Color.primaryGreen500
    case .SOS:
        return Color.accentRedSos
    case .SOSSent, .SOSSending:
        return Color.accentRedSosDisabled
    case .secondaryGuide:
        return Color.neutralWhite
    }
}
