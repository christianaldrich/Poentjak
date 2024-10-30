//
//  TakePhotoComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 29/10/24.
//

import SwiftUI

struct TakePhotoComponent: View {
    
    var action: () -> Void
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 296, height: 296)
                .foregroundStyle(Color.neutralWhite)
                .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
                .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 0)
            
            Button{
                action()
            }label: {
                Image.LabelIcon.addBig
                    
            }
            
                
        }
    }
}

#Preview {
    TakePhotoComponent(action: {print("Open camera is activated")})
}
