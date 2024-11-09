//
//  EditMedicalRecordsView.swift
//  Poentjak
//
//  Created by Shan Havilah on 09/11/24.
//

import SwiftUI

struct EditMedicalRecordsView: View {
    // @StateObject var viewModel: EditProfileViewModel
    @Binding var medicalNeeds: String
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text("Do you have any specific medical needs?")
                        .foregroundColor(Color.primaryGreen500)
                        .font(.title3Emphasized)
                        .padding(.leading, 24)
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 4) {
                    CustomTextFieldMedical(text: $medicalNeeds)
                    
                    Text("*optional")
                        .font(.footnoteRegular)
                        .foregroundColor(.neutralGrayTertiaryGray)
                        .padding(.horizontal, 32)
                }
                .padding(.top, 10)
                
            }
            Spacer()
            
            CustomLargeButtonComponent(state: .enabled, text: "Save Changes"){
                
            }
            .frame(width: 340, height: 72)
        }
    }
}

struct EditMedicalRecordsView_Previews: PreviewProvider {
    @State static var medicalNeeds = "dfd"
    
    static var previews: some View {
        EditMedicalRecordsView(medicalNeeds: $medicalNeeds)
    }
}
