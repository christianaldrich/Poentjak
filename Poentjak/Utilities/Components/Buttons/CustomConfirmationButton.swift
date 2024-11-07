//
//  CustomConfirmationButton.swift
//  Poentjak
//
//  Created by Shan Havilah on 07/11/24.
//

import SwiftUI

struct CustomConfirmationButton: View {
    var state: ButtonState = .enabled
    var text: String
    var action: () -> Void
    var body: some View {
        Button {
            if state == .enabled {
                action()
            }
        } label: {
            ZStack {
                Rectangle()
                    .fill(backgroundColorButton(for: state))
                    .cornerRadius(16)
                    

                if state == .loading {
                    HStack {
                        CircularLoadingView()
                        Text("Loading")
                            .font(.calloutEmphasized)
                            .kerning(0.4)
                            .foregroundColor(foregroundColorButton(for: state))
                    }
                } else {
                    Text(text)
                        .foregroundColor(foregroundColorButton(for: state))
                        .font(.calloutEmphasized)
                        .kerning(0.4)
                }
            }
            .frame(width: 279, height: 48)
        }
        .disabled(state == .disabled || state == .loading)
    }
}

#Preview {
    CustomConfirmationButton(text: "Yes, I've returned"){
        
    }
}
