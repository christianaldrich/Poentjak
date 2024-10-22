//
//  SignUpButtonComponent.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 14/10/24.
//

import SwiftUI

struct CustomPrimaryButtonComponent: View {
    var state: ButtonState = .disabled
    var text: String = ""
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
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(state == .secondary ? Color.primaryGreen500 : .clear, lineWidth: state == .secondary ? 1 : 0)
                    )

                if state == .loading {
                    HStack {
                        Text("Loading")
                            .font(.customPrimaryButton)
                            .kerning(0.4)
                            .foregroundColor(foregroundColorButton(for: state))
                        
                        CircularLoadingView()
                    }
                } else {
                    Text(text)
                        .font(state == .secondary ? .calloutRegular : .customPrimaryButton)
                        .kerning(0.4)
                        .foregroundColor(foregroundColorButton(for: state))
                }
            }
            .frame(width: 338, height: 55)
        }
        .disabled(state == .disabled || state == .loading)
    }
}


// Preview
#Preview {
    VStack {
        CustomPrimaryButtonComponent(state: .enabled, text: "Sign Up") {
            print("Sign Up button tapped")
        }
        
        CustomPrimaryButtonComponent(state: .disabled, text: "Evacuate") {
            print("Disabled button tapped")
        }
        
        CustomPrimaryButtonComponent(state: .loading) {
            print("Loading button tapped")
        }
        
        CustomPrimaryButtonComponent(state: .secondary, text: "Log In") {
            print("Secondary button tapped")
        }
    }
    .padding()
}

