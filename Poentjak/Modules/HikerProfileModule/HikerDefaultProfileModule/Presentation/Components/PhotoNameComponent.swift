//
//  PhotoNameComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 10/11/24.
//

import SwiftUI

struct PhotoNameComponent: View {
    
    var profileURL: String
    var name: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 340, height: 75)
                .foregroundStyle(.white)
                .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
                .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 0)
            
            HStack{
                Image("profPic")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                Text("\(name)")
                    .font(.headlineRegular)
                    .foregroundStyle(Color.primaryGreen500)
                    
                Spacer()
            }
            .padding()
            .frame(width: 340, height: 75)
            
        }
    }
}

#Preview {
    PhotoNameComponent(profileURL: "profPic", name: "Joko")
}
