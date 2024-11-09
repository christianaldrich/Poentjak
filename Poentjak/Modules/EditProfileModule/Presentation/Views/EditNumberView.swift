//
//  EditNumberView.swift
//  Poentjak
//
//  Created by Shan Havilah on 08/11/24.
//

import SwiftUI

struct EditNumberView: View {
    //@StateObject var viewModel: EditProfileViewModel
    @Binding var number: Int
    var state: WheelPicker
        
    var body: some View {
        VStack{
            HStack{
                Text("\(state.title)")
                    .foregroundColor(Color.primaryGreen500)
                    .font(.title3Emphasized)
                    .padding(.leading, 24)
                Spacer()
            }
            Spacer()
            CustomWheelComponent(wheelType: state, selectedNumber: $number)
            Spacer()
            CustomLargeButtonComponent(state: .enabled, text: "Save Changes"){
                
            }
            .frame(width: 340, height: 72)
        }
    }
}

struct EditNumberView_Previews: PreviewProvider {
    @State static var previewNumber = 25 // Provide an initial value for the preview

    static var previews: some View {
        EditNumberView(number: $previewNumber, state: .age)
    }
}
