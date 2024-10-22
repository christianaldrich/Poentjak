//
//  EmergencyContactButton.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 22/10/24.
//

import SwiftUI

struct EmergencyContactButton: View {
    var value: String
    var action: () -> Void
    
    var body: some View {
        
        Button{
            action()
        } label: {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.primaryGreen500)
                .frame(width: 340 ,height: 40)
                .foregroundStyle(Color.neutralWhite)
            
                .overlay {
                    HStack {
                        Image.AdminIcon.call
                        Text("Emergency Contact - \(value)")
                            .foregroundStyle(Color.primaryGreen500)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color.primaryGreen500)
                            .font(.system(size: 16, weight: .bold))
                    }
                    .padding(.horizontal, 16)
                }
        }
        
        
    }
}

#Preview {
    EmergencyContactButton(value: "Mom"){
        
    }
}
