//
//  CustomFullNameTextFieldComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 30/10/24.
//

import SwiftUI

struct CustomFullNameTextFieldComponent: View {
    @Binding var name: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Let's start with your full name")
                .font(.title3Emphasized)
                .padding(.leading, 17)
            TextField("Insert full name", text: $name)
                .padding()
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal)
            
        }
    }
}

//#Preview {
//    CustomFullNameTextFieldComponent()
//}
