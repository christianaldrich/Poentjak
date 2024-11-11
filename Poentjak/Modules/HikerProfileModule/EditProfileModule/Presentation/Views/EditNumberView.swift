//
//  EditNumberView.swift
//  Poentjak
//
//  Created by Shan Havilah on 08/11/24.
//

import SwiftUI

struct EditNumberView: View {
    @StateObject var viewModel: AuthViewModel
    @ObservedObject var navigationManager: MountainNavigationManager
    //@Binding var number: Int
    var state: WheelPicker
        
    var body: some View {
        VStack{
            HStack{
                Text("\(state.title)")
                    .foregroundColor(Color.primaryGreen500)
                    .font(.title3Emphasized)
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                Spacer()
            }
            Spacer()
            
            if state == .age{
                CustomEditWheelComponent(wheelType: state, selectedNumber: $viewModel.age)
                    .scaleEffect(1.5)
            }
            else if state == .weight{
                CustomEditWheelComponent(wheelType: state, selectedNumber: $viewModel.weight)
                    .scaleEffect(1.5)
            }
            else {
                CustomEditWheelComponent(wheelType: state, selectedNumber: $viewModel.height)
                    .scaleEffect(1.5)
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

//struct EditNumberView_Previews: PreviewProvider {
//    @State static var previewNumber = 25
//
//    static var previews: some View {
//        EditNumberView(number: $previewNumber, state: .age)
//    }
//}
