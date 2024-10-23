//
//  CustomNavigationButton.swift
//  Poentjak
//
//  Created by Felicia Himawan on 21/10/24.
//

import SwiftUI

struct AlertGuideTabBarButton: View {
    @Binding var idSelected: Int
    let id: Int
    var text: String
    
    var isSelected: Bool {
        return idSelected == id
    }

    var body: some View {
        Text(text)
            .font(.bodyEmphasized)
            .padding(.horizontal, 28)
            .padding(.vertical, 14)
            .background(isSelected ? Color.primaryGreen500 : Color.primaryLightGreen)
            .foregroundColor(isSelected ? Color.white : Color.primaryGreen500)
            .cornerRadius(16)
            .onTapGesture {
                idSelected = id
            }
    }
}

#Preview {
    @Previewable @State var idSelected = 2
    var id = 1
    AlertGuideTabBarButton(idSelected: $idSelected, id: id, text: "f")
}
