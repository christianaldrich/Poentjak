//
//  LongRectangleDetail.swift
//  Poentjak
//
//  Created by Felicia Himawan on 20/10/24.
//

import SwiftUI

struct CustomLongRectangleDetail: View {
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
        CustomLongRectangleDetail(type: .note(text: "Asthma"))
        
        CustomLongRectangleDetail(type: .activeHiker(count: 120))
    }
}

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

