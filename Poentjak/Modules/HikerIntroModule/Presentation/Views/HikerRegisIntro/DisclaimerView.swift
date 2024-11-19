//
//  DisclaimerView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 30/10/24.
//

import SwiftUI

struct DisclaimerView: View {
    
    @StateObject var viewModel: AuthViewModel
    @State private var nextViewActive: Bool = false
    @State private var isChecked = false

    
    var body: some View {
        VStack{
            Spacer()
            VStack(spacing: 16){
                Image(systemName: "exclamationmark.circle")
                    .font(.largeTitleEmphasized)
                Text("Disclaimer")
                    .font(.title1Emphasized)
            }
            Spacer()
            
            VStack(alignment: .leading, spacing: 25){
                
                Text("Hikewise helps **prevent emergencies** and\nenhance mountain search and rescue.")
                
                Text("The **information** is for guidance only and\n**does not replace professional medical advice or treatment.**")
                
                Text("**Guides** provided are for your **reference**,\nand not mandatory to follow. **Users remain\nresponsible for their actions.**")
                
                Text("By **sharing** your personal **information** and\nlocation, **rangers can assist you more\nquickly.** Learn more about how we collect and protect your data in our privacy policy.")
            }
            .font(.subheadlineRegular)
            
            Spacer()
            
            HStack {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(isChecked ? Color.primaryGreen500 : Color.neutralGrayTertiaryGray)
                    .onTapGesture {
                        isChecked.toggle()
                    }
                
                Text("I agree to the ")
                    + Text("Terms and Conditions")
                        .underline()
                        .foregroundColor(Color.primaryGreen500)
                    + Text(" and ")
                    + Text("Privacy Policy")
                        .underline()
                        .foregroundColor(Color.primaryGreen500)
                
                    
            }
            .font(.caption2Regular)
            
            .padding()
            
            Spacer()
            
            // Custom Button
            CustomLargeButtonComponent(
                state: isChecked ? .enabled : .disabled,
                text: "I agree"
            ) {
                if isChecked {
                    viewModel.currentIndex += 1
                    nextViewActive = true
                }
            }
            .disabled(!isChecked)
            
            
            //                CustomLargeButtonComponent(state: .enabled, text: "I agree"){
            //
            //                    viewModel.currentIndex += 1
            //                    nextViewActive = true
            //                }
            
            
            
            Spacer()
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButtonComponent(action: {
            
        }).padding(.horizontal, 16))
        .navigationDestination(isPresented: $nextViewActive){
            FirstNameLastNameView(viewModel: viewModel)
        }
        .foregroundStyle(Color.primaryGreen500)
        .padding()
        
    }
}

//#Preview {
//    DisclaimerView(viewModel: AuthViewModel(useCase: DefaultAuthUseCase(authRepository: DefaultAuthRepository(), userRepository: DefaultUserRepository())))
//}
