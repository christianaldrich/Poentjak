//
//  PhotoNameComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 10/11/24.
//

import SwiftUI

struct PhotoNameComponent: View {
    
    @Binding var name: String
    
//    var profilePhoto = UIImage()
    @StateObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 340, height: 75)
                .foregroundStyle(.white)
                .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
                .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 0)
            
            HStack{
                
                if let image = authViewModel.retrievedImage{
                    Image(uiImage: image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                        .clipShape(Circle())
                }
                        
                
                
                Text("\(name)")
                    .font(.headlineRegular)
                    .foregroundStyle(Color.primaryGreen500)
                
                Spacer()
            }
            .padding()
            .frame(width: 340, height: 75)
            
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.001){
                authViewModel.retrievePhoto(userName: name)
            }
        }
        
    }
}

//#Preview {
//    @Binding var name: String = "kocakgeming"
//    PhotoNameComponent(name: name, authViewModel: AuthViewModel(useCase: DefaultAuthUseCase(authRepository: DefaultAuthRepository(), userRepository: DefaultUserRepository())))
//}
