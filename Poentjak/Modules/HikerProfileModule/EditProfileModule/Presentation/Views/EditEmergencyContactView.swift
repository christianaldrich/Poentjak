//
//  EditEmergencyContactView.swift
//  Poentjak
//
//  Created by Shan Havilah on 09/11/24.
//

import SwiftUI

struct EditEmergencyContactView: View {
    @StateObject var viewModel: AuthViewModel
    @ObservedObject var navigationManager: MountainNavigationManager
//    @Binding var contactName: String
//    @Binding var contactNumber: String
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text("Who should we call in an\nemergency?")
                        .foregroundColor(Color.primaryGreen500)
                        .font(.title3Emphasized)
                        .padding(.horizontal, 24)
                    Spacer()
                }
                CustomTextFieldEmergencyContactName(text: $viewModel.contactName)
                    .padding(.top, 10)
                CustomTextFieldEmergencyContactNumber(text: $viewModel.contactNumber)
                    .padding(.top, 10)
            }
            Spacer()
            
            CustomLargeButtonComponent(state: .enabled, text: "Save Changes"){
                navigationManager.popToPrevious()
                
            }
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                    BackButtonComponent{
//                        navigationManager.popToPrevious()
                    }
            }
        }
    }
}

//struct EditEmergencyContactView_Previews: PreviewProvider {
//    @State static var contactName = "" // Provide an initial value for the preview
//    @State static var contactNumber = ""
//    
//    static var previews: some View {
//        EditEmergencyContactView(contactName: $contactName, contactNumber: $contactNumber)
//    }
//}
