//
//  CustomTextFieldEmergencyContactNumber.swift
//  Poentjak
//
//  Created by Shan Havilah on 29/10/24.
//

import SwiftUI

struct CustomTextFieldEmergencyContactNumber: View {
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Emergency Contact Number")
                .font(.subheadlineRegular)
                .foregroundColor(Color.primaryGreen500) // Replace with your custom color
            
            TextField("+62 ", text: $text)
                .font(.bodyRegular)
                .textFieldStyle(PlainTextFieldStyle())
                .keyboardType(.numberPad) // Set keyboard type to number pad
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.neutralGrayQuaternaryGray, lineWidth: 1)
                )
                .onAppear {
                    // Set initial text if it doesn't already start with +62
                    if !text.starts(with: "+62 ") {
                        text = "+62 "
                    }
                }
                .onChange(of: text) { newValue in
                    // Allow only digits, and ensure text always starts with +62
                    let filtered = newValue.filter { $0.isNumber || $0 == "+" || $0 == "6" || $0 == "2" }
                    
                    if !filtered.starts(with: "+62 ") {
                        // Remove unwanted characters and prepend +62
                        text = "+62 " + filtered.drop(while: { $0 == "+" || $0 == "6" || $0 == "2" })
                    } else {
                        text = filtered
                    }
                }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    StateWrapper2()
}

struct StateWrapper2: View {
    @State private var text: String = ""
    
    var body: some View {
        CustomTextFieldEmergencyContactNumber(text: $text)
    }
}
