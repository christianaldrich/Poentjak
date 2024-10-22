//
//  EmergencyContactViewComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 22/10/24.
//

import SwiftUI

struct EmergencyContactViewComponent: View {
    
    let contactName: String
    let contactNumber: String
    
    @StateObject private var viewModel = ActiveHikersViewModel(activeHikersUseCase: ActiveHikersUseCase(activeHikersRepository: ActiveHikersRepository(), userRepository: DefaultUserRepository()))
    
    //    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        VStack( spacing: 11){
            HStack{
                
                Spacer()
                
                Button{
//                    print("asdfasdf")
                    dismiss()
                }label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.primaryGreen500)
                }
            }
            
            VStack(spacing: 48){
                VStack(alignment:.leading, spacing: 24){
                    Text("Emergency Contact")
                        .font(.title2Emphasized)
                        .foregroundStyle(Color.primaryGreen500)
                    
                    HStack{
                        Text("\(contactName)")
                        Spacer()
                        Text("\(contactNumber)")
                    }
                }
                
                CustomPrimaryButtonComponent(state: .enabled,text: "Call emergency contact"){
                    
                    viewModel.callPhoneNumber(phoneNumber: contactNumber)
                }
            }
//            Spacer()
        }
        .padding()
        
    }
}

#Preview {
    EmergencyContactViewComponent(contactName: "Joko", contactNumber: "081231231")
}
