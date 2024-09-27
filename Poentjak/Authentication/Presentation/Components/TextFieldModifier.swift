//
//  TextFieldModifier.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .padding(.horizontal, 24)
            .cornerRadius(10)
    }
}


