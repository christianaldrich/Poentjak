//
//  CustomPopUpExtendTime.swift
//  Poentjak
//
//  Created by Felicia Himawan on 03/11/24.
//

import SwiftUI

struct CustomPopUpExtendTime: View {
    var title: String
    var onConfirm: () -> Void
    var onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.title3Emphasized)
                .foregroundColor(.primaryGreen500)
            
            Button(action: onConfirm) {
                Text("Confirm")
                    .font(.calloutEmphasized)
                    .padding(.horizontal, 22)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryGreen500)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            
            Button(action: onCancel) {
                Text("Cancel")
                    .font(.calloutEmphasized)
                    .padding(.horizontal, 22)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.primaryGreen500)
                    .cornerRadius(16)
            }
            
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 34)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 4, x: 0, y: 4)
        .shadow(color: .black.opacity(0.04), radius: 2, x: 0, y: 0)
        .padding(.horizontal, 35)
        
    }
}

#Preview {
    CustomPopUpExtendTime(title: "Extend time by 1 hour?", onConfirm: {
        print("confirm")
    }, onCancel: {
        print("cancel")
    })
}
