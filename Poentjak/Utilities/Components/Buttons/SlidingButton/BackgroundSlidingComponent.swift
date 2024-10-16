//
//  BackgroundSlidingComponent.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 14/10/24.
//

import SwiftUI

struct BackgroundSlidingComponent: View {

    @State private var hueRotation = false
    var body: some View {
        ZStack(alignment: .leading)  {
            RoundedRectangle(cornerRadius: 50)
                  .fill(
                    LinearGradient(
                      colors: [Color.blue.opacity(0.6), Color.red.opacity(0.6)],
                      startPoint: .leading,
                      endPoint: .trailing
                    )
                  )
                  .hueRotation(.degrees(hueRotation ? 20 : -20))

            Text("Slide to unlock")
                .font(.footnote)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
        }
        .onAppear {
              withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                hueRotation.toggle()
              }
            }
    }

}
