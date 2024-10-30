//
//  BackButtonComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 30/10/24.
//

import SwiftUI

struct BackButtonComponent: View {
    var action: () -> Void
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button{
            action()
            dismiss()
        }label: {
            Image(systemName: "chevron.backward")
                .foregroundStyle(.black)
                .font(.headlineRegular)
                .frame(width: 13)
        }
    }
}

#Preview {
    BackButtonComponent(action: {print("asdf")})
}
