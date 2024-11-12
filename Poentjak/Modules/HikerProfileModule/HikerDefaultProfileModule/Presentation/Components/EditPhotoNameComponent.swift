//
//  EditPhotoNameComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 10/11/24.
//

import SwiftUI

struct EditPhotoNameComponent: View {
    var profileURL: String
    var defaultName: String
    @Binding var name: String
    
    var action: () -> Void
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 340, height: 75)
                .foregroundStyle(.white)
                .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
                .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 0)
            
            HStack{
                Button{
                    action()
                }label: {
                    Image("\(profileURL)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(
                            ZStack {
                                Circle()
                                    .trim(from: 0.0, to:0.5)
                                    .foregroundStyle(Color.primaryGreen500)
                                
                                Text("Edit")
                                    .foregroundColor(.neutralWhiteBiancaWhite)
                                    .font(.caption2Regular)
                                    .offset(y: 12.5)
                            },
                            alignment: .bottom
                        )
                    
                    
                }
                
                TextField("\(defaultName)", text: $name)
                
                Spacer()
            }
            .padding()
            .frame(width: 340, height: 75)
            
        }
    }
}


//#Preview {
//    EditPhotoNameComponent(profileURL: "test", name: .constant("adsf")){
//        
//    }
//}
