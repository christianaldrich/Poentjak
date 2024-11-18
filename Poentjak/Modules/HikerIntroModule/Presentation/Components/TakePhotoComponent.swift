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
                .customShadow()
            
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
