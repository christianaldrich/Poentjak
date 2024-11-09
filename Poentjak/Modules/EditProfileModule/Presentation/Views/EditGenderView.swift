//
//  EditGenderView.swift
//  Poentjak
//
//  Created by Shan Havilah on 08/11/24.
//

import SwiftUI

struct EditGenderView: View {
    //@StateObject var viewModel: EditProfileViewModel
    @Binding var gender: String
    var body: some View {
        VStack{
//            Text("What's your gender?")
//                .font(.headlineRegular)
//                .foregroundColor(Color.primaryGreen500)
            
            CustomEditGenderButtonComponent(gender: $gender)
            Spacer()
            
            CustomLargeButtonComponent(state: .enabled, text: "Save Changes"){
                
            }
            .frame(width: 340, height: 72)
        }
    }
}

struct EditGenderView_Previews: PreviewProvider {
    @State static var previewGender = "Male" // Provide an initial value for the preview
    
    static var previews: some View {
        EditGenderView(gender: $previewGender)
    }
}
