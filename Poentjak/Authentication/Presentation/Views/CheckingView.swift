//
//  CheckingView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import SwiftUI

struct CheckingView: View {
    @StateObject var viewModel: AuthViewModel
    @StateObject var viewModelEmergency: EmergencyProsesViewModel
    
    var body: some View {
        Group {
            
            if viewModel.isLoading {
                            // Show a loading indicator or loading view here if needed
                            // LoadingView()
                        } else if viewModel.userSession != nil {
                            if viewModelEmergency.isEmergencyLoading {
                                // Optionally, show a loading state for emergency session here
                              
                            } else if viewModelEmergency.emergencySessionActive {
                                // If session is active, show the emergency view
                                EmergencyProsesView()
                            } else if viewModel.isAdmin {
                                AdminTabView(viewModel: viewModel)
                            } else {
                                UserView(viewModel: viewModel)
                            }
                        } else {
                            LoginView(viewModel: viewModel)
                        }
            
            
       
            // modified & works tpi agak delay
//            if viewModel.isLoading {
//                
//                //                LoadingView()
//            } else if viewModel.userSession != nil {
//                if viewModelEmergency.emergencySessionActive{
//                    EmergencyProsesView()
//                }
//                else if viewModel.isAdmin {
//                    AdminTabView(viewModel: viewModel)
//                } else {
//                    UserView(viewModel: viewModel)
//                }
//            } else {
//                LoginView(viewModel: viewModel)
//            }
            
            
            // ori punya singgih
            //                        if viewModel.isLoading {
            //
            //                            //                LoadingView()
            //                        } else if viewModel.userSession != nil {
            
            //                            if viewModel.isAdmin {
            //                                AdminTabView(viewModel: viewModel)
            //                            } else {
            //                                UserView(viewModel: viewModel)
            //                            }
            //                        } else {
            //                            LoginView(viewModel: viewModel)
            //                        }
        }
        .onAppear {
            Task {
                await viewModel.fetchCurrentUser()
                viewModelEmergency.fetchEmergency()
                print("checking view: \(viewModelEmergency.emergencySessionActive)")
                
            }
            
        }
    }
}
