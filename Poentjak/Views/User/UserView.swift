//
//  UserView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import SwiftUI

struct UserView: View {
    @StateObject var viewModel: AuthViewModel
    
    
    @State private var showSheet = false
    
    var body: some View {
        NavigationStack{
            if let user = viewModel.userSession {
                Text("Hello, \(user.fullname)!")
            } else {
                Text("no name found")
            }
            
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
            
//            Button(action: {
//                showSheet = true
//            }) {
//                Text("SOS")
//                    .font(.headline)
//                    .padding()
//                    .background(Color.red)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//            .sheet(isPresented: $showSheet) {
//                SheetView().presentationDetents([.medium, .large])
//            }
            
            
            
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
