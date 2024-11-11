//
//  EditMedicalRecordsView.swift
//  Poentjak
//
//  Created by Shan Havilah on 09/11/24.
//

import SwiftUI

struct EditMedicalRecordsView: View {
    @StateObject var viewModel: AuthViewModel
    @ObservedObject var navigationManager: MountainNavigationManager
    //@Binding var medicalNeeds: String
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text("Do you have any specific medical\nneeds? (optional)")
                        .foregroundColor(Color.primaryGreen500)
                        .font(.title3Emphasized)
                        .padding(.horizontal, 24)
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 4) {
                    CustomTextFieldMedical(text: $viewModel.medicalCondition)
                    
                    Text("e.g Asthma")
                        .font(.footnoteRegular)
                        .foregroundColor(.neutralGrayTertiaryGray)
                        .padding(.horizontal, 32)
                }
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

//struct EditMedicalRecordsView_Previews: PreviewProvider {
//    @State static var medicalNeeds = ""
//    
//    static var previews: some View {
//        EditMedicalRecordsView(medicalNeeds: $medicalNeeds)
//    }
//}
