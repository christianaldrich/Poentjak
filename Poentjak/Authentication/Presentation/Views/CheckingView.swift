//
//  CheckingView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import SwiftUI

struct CheckingView: View {
    @StateObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                
//                LoadingView()
            } else if viewModel.userSession != nil {
                if viewModel.isAdmin {
                    AdminTabView(viewModel: viewModel)
                } else {
                    AdminTabView(viewModel: viewModel)
                    //UserView(viewModel: viewModel)
                }
            } else {
                LoginView(viewModel: viewModel)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchCurrentUser()
            }
        }
    }
}
