//
//  CompleteButtonComponent.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 14/10/24.
//

import SwiftUI

struct CustomLargeButtonComponent: View {
    var state: ButtonState = .enabled
    var text: String = "Complete"
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
                            .foregroundColor(foregroundColorButton(for: state))
                    }
                } else {
                    Text(text)
                        .foregroundColor(foregroundColorButton(for: state))
                        .font(.calloutEmphasized)
                }
            }
            .frame(width: 340, height: 72)
        }
        .disabled(state == .disabled || state == .loading)
    }
}

#Preview {
    VStack {
        CustomLargeButtonComponent(state: .disabled){
            print("hi")
        }
        
        CustomLargeButtonComponent(){
            print("hi")
        }
    }
}

