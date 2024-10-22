//
//  CustomTextFieldAuth.swift
//  Poentjak
//
//  Created by Felicia Himawan on 21/10/24.
//
import SwiftUI

struct CustomTextFieldAuth: View {
    @Binding var text: String
    @State private var isSecure: Bool = true
    var titleTextField: String
    var errorMessage: String?
    var isError: Bool
    var isPassword: Bool
    var validationMessage: String?
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !titleTextField.isEmpty {
                Text(titleTextField)
                    .font(.subheadlineRegular)
                    .foregroundColor(Color.primaryGreen500)
            }
            
            HStack {
                if isPassword && isSecure {
                    SecureField("", text: $text)
                        .font(.bodyRegular)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(16)
                } else {
                    TextField("", text: $text)
                        .font(.bodyRegular)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(16)
                }
                
                if isPassword {
                    Button(action: {
                        isSecure.toggle()
                    }) {
                        (isSecure ? Image.TextFieldIcon.eyeHide : Image.TextFieldIcon.eyeUnhide)
                            .padding(.trailing, 16)
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isError ? Color.errorRed500 : Color.neutralGrayQuaternaryGray, lineWidth: 1)
            )
            
            if let validationMessage = validationMessage, !isError {
                Text(validationMessage)
                    .font(.footnoteRegular)
                    .foregroundColor(Color.neutralGrayTertiaryGray)
            }
            
            if let errorMessage = errorMessage, isError {
                Text(errorMessage)
                    .font(.footnoteRegular)
                    .foregroundColor(Color.errorRed500)
            }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    StatefulPreviewWrapper("hjgh") { CustomTextFieldAuth(
        text: $0,
        titleTextField: "Email Address",
        errorMessage: "Email has already been used",
        isError: false,
        isPassword: false
    )}
    .padding(.vertical, 16)
    
    StatefulPreviewWrapper("hjgh") { CustomTextFieldAuth(
        text: $0,
        titleTextField: "Email Address",
        errorMessage: "Email has already been used",
        isError: false,
        isPassword: false,
        validationMessage: "Must be at least 8 characters"
    )}
    .padding(.vertical, 16)
    
    StatefulPreviewWrapper("hjgh") { CustomTextFieldAuth(
        text: $0,
        titleTextField: "Password",
        errorMessage: "Must be 8 characters",
        isError: true,
        isPassword: true,
        validationMessage: "Must be at least 8 characters"
    )}
}

struct StatefulPreviewWrapper<T: View>: View {
    @State var value: String
    var content: (Binding<String>) -> T
    
    init(_ initialValue: String, @ViewBuilder content: @escaping (Binding<String>) -> T) {
        _value = State(initialValue: initialValue)
        self.content = content
    }
    
    var body: some View {
        content($value)
    }
}
