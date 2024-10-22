//
//  HalfButtonComponent.swift
//  Poentjak
//
//  Created by Shan Havilah on 19/10/24.
//

import SwiftUI

struct HalfButtonComponent: View {
    var halfType: HalfButton
    //var action: () -> Void
    //var state: ButtonState = .enabled
    
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                Rectangle()
                    .fill(backgroundColorButton(for: halfType))
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(halfType == .secondaryGuide ? Color.primaryGreen500 : .clear, lineWidth: halfType == .secondaryGuide ? 2 : 0)
                    )
                
                HStack {
                    halfType.iconName?
                        .renderingMode(.template) // This allows the icon to be tinted
                        .foregroundColor(foregroundColorButton(for: halfType))
                    
                    Text(halfType.title)
                        .foregroundColor(foregroundColorButton(for: halfType))
                        .font(.title3Emphasized)
                }
            }
            .frame(width: 162, height: 54)
        }
        .disabled(halfType == .SOSSending || halfType == .SOSSent)
    }
}

#Preview {
    VStack{
        HalfButtonComponent(halfType: .primaryGuide)
        HalfButtonComponent(halfType: .SOS)
        HalfButtonComponent(halfType: .SOSSending)
        HalfButtonComponent(halfType: .SOSSent)
        HalfButtonComponent(halfType: .secondaryGuide)
    }
}
