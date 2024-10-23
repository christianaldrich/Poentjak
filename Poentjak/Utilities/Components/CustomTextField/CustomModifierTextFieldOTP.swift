//
//  CustomModifierTextFieldOTP.swift
//  Poentjak
//
//  Created by Felicia Himawan on 21/10/24.
//

import SwiftUI

struct CustomModifierTextFieldOTP: ViewModifier {
    var isSelected: Bool
    var isError: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(width: 50, height: 50)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isError ? Color.errorRed500 : (isSelected ? Color.primaryGreen500 : Color.neutralGrayQuaternaryGray),
                        lineWidth: 1
                    )
            )
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .font(.calloutRegular)
    }
}

extension View {
    func otpStyle(isSelected: Bool, isError: Bool) -> some View {
        self.modifier(CustomModifierTextFieldOTP(isSelected: isSelected, isError: isError))
    }
}

// MARK: - Example of using the modifier
struct CustomTextFieldOTP: View {
    @State private var otpDigits: [String] = Array(repeating: "", count: 4) // 4-digit OTP
    @State private var isError: Bool = false
    @FocusState private var focusedField: Int?  // To track which TextField is focused
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<4, id: \.self) { index in
                TextField("", text: $otpDigits[index])
                    .otpStyle(isSelected: focusedField == index, isError: isError)
                    .focused($focusedField, equals: index)  // Track the focus
                    .onTapGesture {
                        focusedField = index  // Set the selected field when tapped
                    }
                    .onChange(of: otpDigits[index]) { newValue in
                        // Move to the next field after entering a digit
                        if newValue.count == 1 && focusedField != otpDigits.count - 1 {
                            focusedField = (focusedField ?? 0) + 1
                        } else if newValue.isEmpty {
                            // Reset error state if the field is emptied
                            isError = false
                        }
                    }
                    .onChange(of: otpDigits) { newValue in
                        // Validate OTP after all fields are filled
                        if newValue.allSatisfy({ $0.count == 1 }) {
                            validateOTP()
                        }
                    }
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, 24)
    }
    
    // Simulating OTP validation
    func validateOTP() {
        let correctOTP = ["1", "2", "3", "4"]
        isError = otpDigits != correctOTP
    }
}

#Preview {
    CustomTextFieldOTP()
}
