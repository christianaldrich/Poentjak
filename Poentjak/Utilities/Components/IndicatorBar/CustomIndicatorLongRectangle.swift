//
//  CustomIndicatorLongRectangle.swift
//  Poentjak
//
//  Created by Felicia Himawan on 22/10/24.
//

import SwiftUI

struct CustomIndicatorLongRectangle: View {
    let totalCount: Int // Total number of indicators
    let currentIndex: Int // Current active index (0-based)
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                ForEach(0..<totalCount, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 5)
                        .fill(colorForIndex(index))
                        .frame(height: 5)
                }
            }
            .padding(.bottom, 4)
            
            Text("\(currentIndex)/\(totalCount)")
                .font(.footnoteRegular)
                .foregroundStyle(Color.primaryGreen500)
        }
        .padding(.horizontal, 25)
        
    }
    
    private func colorForIndex(_ index: Int) -> Color {
        if index < currentIndex {
            return Color.primaryGreen500
        } else if index == currentIndex {
            return Color.primaryLightGreen
        } else {
            return Color.neutralGrayQuaternaryGray
        }
    }
}

#Preview {
    VStack {
        CustomIndicatorLongRectangle(totalCount: 4, currentIndex: 0)
    }
}
