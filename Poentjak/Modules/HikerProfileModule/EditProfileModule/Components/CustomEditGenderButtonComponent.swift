//
//  CustomEditGenderButtonComponent.swift
//  Poentjak
//
//  Created by Shan Havilah on 08/11/24.
//

import SwiftUI

struct CustomEditGenderButtonComponent: View {
    @Binding var gender: String

    var body: some View {
        VStack(alignment: .leading){
            
            Text("What's your gender?")
                .font(.headlineRegular)
                .foregroundColor(Color.primaryGreen500)
                .padding(.bottom, 20)
            
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
        .customShadow()
    }
}
