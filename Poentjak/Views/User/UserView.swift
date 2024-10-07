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
        NavigationStack{
            Text("Hello, User!")
            
            
            // Button to navigate to DueDateView
            NavigationLink(destination: DueDateView()) {
                Text("Start tracking")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
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
}

//#Preview {
//    UserView()
//}
