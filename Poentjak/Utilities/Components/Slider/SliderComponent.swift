//
//  SliderComponent.swift
//  Poentjak
//
//  Created by Shan Havilah on 29/10/24.
//

import SwiftUI

struct SliderComponent: View {
    @State private var sliderValue: Double = 1.0

    var body: some View {
        VStack {
            VStack {
                // The custom slider
                CustomSlider(value: $sliderValue, range: 1...5, step: 1)
                    .padding(.horizontal)

                // Number labels below the slider
//                HStack {
//                    ForEach(1...5, id: \.self) { number in
//                        Text("\(number)")
//                            .font(.customFootNote)
//                            .foregroundColor(Color.primaryGreen500)
//                            .frame(maxWidth: .infinity)
//                    }
//                }
//                .padding(.horizontal)
            }
        }
        .padding()
    }
}

#Preview {
    SliderComponent()
}
