//
//  UserView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import SwiftUI

struct UserView: View {
    @StateObject var viewModel: AuthViewModel
    var body: some View {
        Text("Hello, User!")
        
        Button(action: {
            Task {
                await viewModel.signOut()
            }
                   }) {
                       Text("Sign Out")
                           .font(.headline)
                           .padding()
                           .background(Color.red)
                           .foregroundColor(.white)
                           .cornerRadius(10)
                   }
                   .padding()
    }
}

//#Preview {
//    UserView()
//}
