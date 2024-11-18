//
//  View+Extensions.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 18/11/24.
//

import SwiftUI

struct CustomShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 2)
            .shadow(color: .black.opacity(0.02), radius: 3, x: 0, y: 0)
    }
}

extension View {
    func customShadow() -> some View {
        self.modifier(CustomShadowModifier())
    }
}

