//
//  BaseButtonStyle.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 15/10/24.
//

import SwiftUI

struct BaseButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.default, value: configuration.isPressed)
    }

}
