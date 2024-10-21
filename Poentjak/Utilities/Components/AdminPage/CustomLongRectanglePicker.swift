//
//  LongRectanglePicker.swift
//  Poentjak
//
//  Created by Felicia Himawan on 20/10/24.
//
//

import SwiftUI

struct CustomLongRectanglePicker: View {
    var assignedRangers: [String]
    var action: () -> Void
    
    var body: some View {
        HStack {
            if assignedRangers.isEmpty {
                Text("None")
                    .font(.subheadlineRegular)
                    .foregroundColor(Color.neutralGrayTertiaryGray)
            } else {
                Text(assignedRangers.joined(separator: ", "))
                    .font(.subheadlineRegular)
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            Image(systemName: "chevron.down")
                .foregroundColor(.black)
        }
        .padding(.horizontal ,16)
        .padding(.vertical, 20)
        .frame(width: 340)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.neutralGrayQuaternaryGray, lineWidth: 1)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            action()
        }
    }
}

// MARK: - Preview
#Preview {
    VStack (alignment: .center){
        // contoh kalo [ ] kosong
        CustomLongRectanglePicker(
            assignedRangers: [],
            action: {
                print("action 1")
            }
        )
        
        // contoh kalo [ ] ada isi
        CustomLongRectanglePicker(
            assignedRangers: ["Ranger 1", "Ranger 2"],
            action: {
                print("action 2")
            }
        )
    }
    
}
