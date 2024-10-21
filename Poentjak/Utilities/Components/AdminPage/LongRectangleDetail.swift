//
//  LongRectangleDetail.swift
//  Poentjak
//
//  Created by Felicia Himawan on 20/10/24.
//

import SwiftUI

struct LongRectangleDetail: View {
    enum DetailType {
        case note(text: String)
        case activeHiker(count: Int)
    }
    
    let type: DetailType
    
    var body: some View {
        HStack(spacing: 8) {
            switch type {
            case .note(let text):
                Image.HikerDetailIcon.note
                    
                Text(text)
                    .font(.footnoteRegular)
                    .foregroundStyle(Color.primaryGreen500)
            
            case .activeHiker(let count):
                Text("Active hikers:")
                    .font(.footnoteRegular)
                    .foregroundStyle(Color.primaryDarkGreen)
                Text("\(count)")
                    .font(.footnoteRegular)
                    .foregroundStyle(Color.primaryDarkGreen)
            }
        }
        .frame(width: 340, alignment: .leading)
        .padding(16)
        .background(Color.neutralGrayCoolGray)
        .cornerRadius(4)
    }
}

#Preview {
    VStack(spacing: 10) {
        LongRectangleDetail(type: .note(text: "Asthma"))
        
        LongRectangleDetail(type: .activeHiker(count: 120))
    }
}
