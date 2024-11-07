//
//  SliderComponent.swift
//  Poentjak
//
//  Created by Shan Havilah on 29/10/24.
//

import SwiftUI

struct SliderComponent: View {
    @Binding var sliderValue: Double

    var body: some View {
        VStack {
            VStack {
                CustomSlider(value: $sliderValue, range: 1...5, step: 1)
                    .padding(.horizontal)
            }
        }
        .padding()
    }
}

//#Preview {
//    SliderComponent()
//}
