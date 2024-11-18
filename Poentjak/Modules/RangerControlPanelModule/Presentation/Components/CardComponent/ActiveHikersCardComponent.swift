//
//  ActiveHikersCardComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 20/10/24.
//

import SwiftUI

struct ActiveHikersCardComponent: View {
    
    @State var name: String
    @State var gender: String
    @State var dueDate: Date
    @State private var image: UIImage?
    

    var viewModel : ActiveHikersViewModel
    @StateObject var authViewModel: AuthViewModel

    var body: some View {
//        Text("Hello, World!")
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 340, height: 67)
                .foregroundStyle(.white)
                .customShadow()
            
            HStack{
                
                if let image = image{
                    Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 38,height: 36)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 38,height: 36)
                        .foregroundColor(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                }
                
                Text("\(name)")
                    .font(.headlineRegular)
                viewModel.customGender(gender)
                Spacer()
                viewModel.countDue(input: dueDate)
            }
            .padding()
            .frame(width: 308)
        }
        .onAppear{
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
//                authViewModel.retrievePhoto(userName: name)
            authViewModel.retrievePhotoRanger(userName: name){image in
                if let image = image {
                    print("Successfully retrieved image for user TEST.")
                    // Update the UI with the image
                    DispatchQueue.main.async {
                        self.image = image
                    }
                } else {
                    print("Failed to retrieve image for user TEST.")
                }
                
            }
//            }
        }
 
    }
    
    
}

//#Preview {
//    ActiveHikersCardComponent(name: "Joko", gender: "male", dueDate: Date())
//}
