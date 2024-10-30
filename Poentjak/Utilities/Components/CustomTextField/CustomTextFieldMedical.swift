//
//  CustomTextFieldMedical.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 30/10/24.
//

import Foundation
import SwiftUI

struct CustomTextFieldMedical: View {
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
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
