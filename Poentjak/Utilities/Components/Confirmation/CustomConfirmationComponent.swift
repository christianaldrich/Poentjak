//
//  CustomConfirmationComponent.swift
//  Poentjak
//
//  Created by Shan Havilah on 07/11/24.
//

import SwiftUI

enum confirmationState {
    case returned
    case logout
    case evacuated
    
    var title: String{
        switch self {
        case .returned:
            return "Returned to basecamp?"
        case .logout:
            return "Log out?"
        case .evacuated:
            return "Have you been rescued?"
        }
    }
    
    var buttonTitle: String{
        switch self {
        case .returned:
            return "Yes, I've returned"
        case .logout:
            return "Yes, log out?"
        case .evacuated:
            return "Yes, I'm safe"
        }
    }
}

struct CustomConfirmationComponent: View {
    var confirmType: confirmationState
    @Binding var isModalVisible: Bool
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.neutralWhite)
            .cornerRadius(16)
            
            VStack{
                Text(confirmType.title)
                    .font(.title2Semi)
                    .foregroundColor(Color.primaryGreen500)
                CustomConfirmationButton(text: confirmType.buttonTitle){
                    action()
                }
                Button{
                    isModalVisible = false
                } label: {
                    Text("Cancel")
                        .font(.calloutEmphasized)
                        .foregroundColor(Color.primaryGreen500)
                    
                }
                .buttonStyle(.plain)
                .padding(.top, 5)
            }
        }
        .frame(width: 321, height: 197)
    }
}

//#Preview {
//    CustomConfirmationComponent(confirmType: .evacuated){
//        
//    }
//}
