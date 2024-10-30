//
//  NextViewTest.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 29/10/24.
//

import SwiftUI

struct NextViewTest: View {
    @State private var contactName: String = ""
    @State private var contactNumber: String = ""
    @State private var navigateNext = false
    
    var isFormFilled: Bool {
        !contactName.isEmpty && !contactNumber.isEmpty
    }
    
    var body: some View {
        
            VStack(alignment: .leading) {  
                Text("Who should we call in an emergency?")
                    .font(.title3Emphasized)
                    .foregroundStyle(Color.primaryGreen500)
                    .padding(.horizontal, 16)
                
                VStack(alignment: .leading, spacing: 8) {
                    TextField("Enter Contact Name", text: $contactName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 16)
                    
                    TextField("Enter Contact Number", text: $contactNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 16)
                        .keyboardType(.phonePad)
                }
                
                Spacer()
                
                // NavigationLink with isActive Binding
                NavigationLink(destination: MedicalReportView(), isActive: $navigateNext) {
                    EmptyView() // Hidden NavigationLink
                }
                
                CustomLargeButtonComponent(state: isFormFilled ? .enabled : .disabled, text: "Next") {
                    if isFormFilled {
                        navigateNext = true
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    
}

#Preview {
    NextViewTest()
}
