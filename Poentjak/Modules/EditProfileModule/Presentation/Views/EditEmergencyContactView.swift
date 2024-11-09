//
//  EditEmergencyContactView.swift
//  Poentjak
//
//  Created by Shan Havilah on 09/11/24.
//

import SwiftUI

struct EditEmergencyContactView: View {
    // @StateObject var viewModel: EditProfileViewModel
    @Binding var contactName: String
    @Binding var contactNumber: String
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text("Who should we call in an emergency?")
                        .foregroundColor(Color.primaryGreen500)
                        .font(.title3Emphasized)
                        .padding(.leading, 24)
                    Spacer()
                }
                CustomTextFieldEmergencyContactName(text: $contactName)
                    .padding(.top, 10)
                CustomTextFieldEmergencyContactNumber(text: $contactNumber)
                    .padding(.top, 10)
            }
            Spacer()
            
            CustomLargeButtonComponent(state: .enabled, text: "Save Changes"){
                
            }
            .frame(width: 340, height: 72)
        }
    }
}

struct EditEmergencyContactView_Previews: PreviewProvider {
    @State static var contactName = "dfd" // Provide an initial value for the preview
    @State static var contactNumber = "34954398"
    
    static var previews: some View {
        EditEmergencyContactView(contactName: $contactName, contactNumber: $contactNumber)
    }
}
