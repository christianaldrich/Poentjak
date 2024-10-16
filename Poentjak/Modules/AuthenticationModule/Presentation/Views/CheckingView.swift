//
//  CheckingView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//

import SwiftUI

struct CheckingView: View {
    @StateObject var viewModel: AuthViewModel
    @ObservedObject var viewModelEmergency: EmergencyProsesViewModel
    
    var body: some View {
        Group {
            
            if viewModel.isLoading {
                            // LoadingView()
            }
            else if viewModel.userSession != nil {
                if viewModelEmergency.emergencySessionActive { // harus cek sudah pilih tanggal belum 
                    EmergencyProsesView()
                }
                else if viewModel.isAdmin {
                    AdminTabView(viewModel: viewModel)
                }
                else {
//                UserView(viewModel: viewModel)
                                MountainsTracksView(authViewModel: viewModel)
//                                DueDateView()
                }
            }
            else {
                LoginView(viewModel: viewModel)
//                TestingIcon()
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
//        .onChange(of: viewModelEmergency.emergencySessionActive) { newValue in
//            EmergencyProsesView()
//        }
        .onAppear {
            print("checking view: \(viewModelEmergency.emergencySessionActive)")
            Task {
                await viewModel.fetchCurrentUser()
                viewModelEmergency.fetchEmergency()
                
                
            }
            
        }
        
    }
}
