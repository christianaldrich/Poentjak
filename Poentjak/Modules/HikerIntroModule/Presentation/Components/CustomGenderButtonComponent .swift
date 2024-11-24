//
//  CustomGenderButtonComponent .swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 30/10/24.
//

import SwiftUI

struct CustomGenderButtonComponent: View {
    @Binding var gender: String

    var body: some View {
        VStack(alignment: .leading){
            
            Text("As well as your gender.")
                .font(.title3Emphasized)
                .foregroundStyle(Color.primaryGreen500)
            
            GenderButtonComponent(genderType: .male, state: gender == "male" ? .enabled : .secondary){
                gender = "male"
            }
            .customShadow()
            
            GenderButtonComponent(genderType: .female, state: gender == "female" ? .enabled : .secondary){
                gender = "female"
            }
            .customShadow()
            
            GenderButtonComponent(genderType: .others, state: gender == "others" ? .enabled : .secondary){
                gender = "others"
            }
            .customShadow()
            
        }
        
    }
}

//#Preview {
//    CustomGenderButtonComponent()
//}
