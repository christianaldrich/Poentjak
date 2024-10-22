//
//  CustomNavigationAlertGuide.swift
//  Poentjak
//
//  Created by Felicia Himawan on 22/10/24.
//

import SwiftUI

struct AlertGuideTabBar: View {
    @Binding var idSelected: Int
    var text: String
    
    var body: some View {
        HStack {
            ForEach(Array(text.enumerated()), id: \.offset) { index, letter in
                AlertGuideTabBarButton(
                    idSelected: $idSelected,
                    id: index+1,
                    text: String(letter)
                )
            }
        }
    }
}

#Preview {
    @Previewable @State var idSelected = 1
    
    AlertGuideTabBar(idSelected: $idSelected, text: "STOP")
}
