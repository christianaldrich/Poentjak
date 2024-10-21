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
    

    var viewModel = ActiveHikersViewModel(activeHikersUseCase: ActiveHikersUseCase(activeHikersRepository: ActiveHikersRepository(), userRepository: DefaultUserRepository()))
    
    var body: some View {
//        Text("Hello, World!")
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 340, height: 67)
                .foregroundStyle(.white)
                .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
                .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 0)
            
            HStack{
                Image("profPic")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 38,height: 36)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                Text("\(name)")
                viewModel.customGender(gender)
                Spacer()
                viewModel.countDue(input: dueDate)
            }
            .padding()
            .frame(width: 308)
        }
 
    }
    
    
}

#Preview {
    ActiveHikersCardComponent(name: "Joko", gender: "male", dueDate: Date())
}
