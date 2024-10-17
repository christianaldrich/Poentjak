//
//  ButtonStyles.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 14/10/24.
//

import SwiftUI

enum ButtonState {
    case enabled
    case disabled
    case loading
    case secondary
}

func foregroundColorButton(for state: ButtonState) -> Color {
    switch state {
    case .enabled, .loading:
        return Color.neutralWhite
    case .disabled:
        return Color.neutralWhite
    case .secondary:
        return Color.primaryGreen500
    }
}

func backgroundColorButton(for state: ButtonState) -> Color {
    switch state {
    case .enabled:
        return Color.primaryGreen500
    case .disabled:
        return Color.primaryDisabledGreen
    case .loading:
        return Color.primaryGreen500
    case .secondary:
        return Color.neutralWhite
    }
}
