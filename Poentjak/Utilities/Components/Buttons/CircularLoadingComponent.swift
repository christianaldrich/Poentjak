//
//  CircularLoadingComponent.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 14/10/24.
//

import Foundation
import SwiftUI

struct CircularLoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(Color.neutralWhite, lineWidth: 2)
                .frame(width: 14, height: 14)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(
                    Animation.linear(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: isAnimating
                )
        }
        .onAppear {
            isAnimating = true
        }
    }
}
