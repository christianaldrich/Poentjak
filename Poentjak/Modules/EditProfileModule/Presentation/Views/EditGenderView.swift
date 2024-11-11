//
//  EditGenderView.swift
//  Poentjak
//
//  Created by Shan Havilah on 08/11/24.
//

import SwiftUI

struct EditGenderView: View {
    @StateObject var viewModel: EditProfileViewModel
    // @Binding var gender: String
    var body: some View {
        VStack{
            CustomEditGenderButtonComponent(gender: $viewModel.gender)
            Spacer()
            
            CustomLargeButtonComponent(state: .enabled, text: "Save Changes"){
                
            }
            .padding(.horizontal, 24)
        }
    }
}

//struct EditGenderView_Previews: PreviewProvider {
//    @State static var previewGender = ""
//    
//    static var previews: some View {
//        EditGenderView(viewModel: EditProfileViewModel)
//    }
//}
