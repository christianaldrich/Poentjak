//
//  CustomChecklistComponent.swift
//  Poentjak
//
//  Created by Felicia Himawan on 21/10/24.
//

import SwiftUI

struct CustomChecklistComponent: View {
    var text: String
    @State private var isChecked: Bool = false
    
    var body: some View {
        HStack(spacing: 16) {
            Button(action: {
                isChecked.toggle()
            }) {
                if isChecked {
                    Image.GuideIcon.guideChecked
                } else {
                    Image.GuideIcon.guideUnchecked
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(text)
                    .font(.subheadlineRegular)
                    .foregroundColor(Color.primaryGreen500)
                    .strikethrough(isChecked, color: Color.primaryGreen500)
                
                Divider()
                    .frame(height: 0.98)
                    .background(Color.neutralGrayLightGray)
            }
        }
        .frame(width: 378, alignment: .leading)
        .padding(.vertical, 8)
    }
}

#Preview {
    CustomChecklistComponent(text: "Checklist Item")
}
