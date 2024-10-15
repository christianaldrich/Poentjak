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
        return Color.white
    case .disabled:
        return Color.white
    case .secondary:
        return Color.blue
    }
}

func backgroundColorButton(for state: ButtonState) -> Color {
    switch state {
    case .enabled:
        return Color.blue
    case .disabled:
        return Color.blue.opacity(0.5)
    case .loading:
        return Color.blue
    case .secondary:
        return Color.white
    }
}
