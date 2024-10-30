//
//  CustomTextFieldEmergencyContact.swift
//  Poentjak
//
//  Created by Shan Havilah on 29/10/24.
//

import SwiftUI

struct CustomTextFieldEmergencyContactName: View {
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text("Emergency Contact Name")
                .font(.subheadlineRegular)
                .foregroundColor(Color.primaryGreen500)
            
            TextField("", text: $text)
                .font(.bodyRegular)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.neutralGrayQuaternaryGray, lineWidth: 1)
                )
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    StateWrapper()
}

struct StateWrapper: View {
    @State private var text: String = ""
    
    var body: some View {
        CustomTextFieldEmergencyContactName(text: $text)
    }
}
