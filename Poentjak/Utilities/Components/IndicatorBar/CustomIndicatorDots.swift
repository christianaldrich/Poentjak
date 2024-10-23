//
//  CustomIndicatorDots.swift
//  Poentjak
//
//  Created by Felicia Himawan on 22/10/24.
//
import SwiftUI

struct CustomIndicatorDots: View {
    let totalDots: Int
    let currentIndex: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalDots, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex ? Color.primaryGreen500 : Color.neutralGrayLightGray)
                    .frame(width: 13, height: 13)
            }
        }
        .padding()
    }
}

#Preview {
    VStack {
        CustomIndicatorDots(totalDots: 5, currentIndex: 2)
    }
}
