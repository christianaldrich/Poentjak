//
//  SlidingButton-Cancel-Component.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 14/10/24.
//


import SwiftUI

struct SlidingButtonCancelComponent: View {
    @State private var isLocked = true

        var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    BackgroundSlidingComponent()
                    DraggingComponent(maxWidth: geometry.size.width, isLocked: $isLocked)
                }
            }
            .frame(height: 50)
            .padding()
        }
}


#Preview {
    SlidingButtonCancelComponent()
}
