//
//  EmergencyTypeButtonComponent.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 14/10/24.
//

import SwiftUI

struct EmergencyButtonComponent: View {
    var iconName: String
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button{
            action()
        } label: {
            HStack {
                Image(iconName)
                    .resizable()
                    .frame(width: 54, height: 54)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                Spacer()
                
                Text(title)
                    .font(.title3Regular)
                    .foregroundColor(Color.black)
                
                Spacer()
                Spacer()
                Spacer()
            }
            .padding()
            .frame(width: 340, height: 64)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 4)
        }
    }
}

#Preview {
    EmergencyButtonComponent(iconName: "dummy", title: "Hypothermia") {
        print("hi")
    }
}
