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
            
            GenderButtonComponent(genderType: .male, state: gender == "male" ? .enabled : .secondary){
                gender = "male"
            }
            
            GenderButtonComponent(genderType: .female, state: gender == "female" ? .enabled : .secondary){
                gender = "female"
            }
            
            GenderButtonComponent(genderType: .others, state: gender == "others" ? .enabled : .secondary){
                gender = "others"
            }
            
        }
        .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
        .shadow(color: Color.black.opacity(0.02), radius: 6, x: 0, y: 0)
    }
}

//#Preview {
//    CustomGenderButtonComponent()
//}
