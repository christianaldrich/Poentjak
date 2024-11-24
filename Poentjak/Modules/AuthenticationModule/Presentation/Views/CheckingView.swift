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
    
    @StateObject var navigationManager = NavigationManager()
    @StateObject var mountainViewModel = MountainsTracksViewModel(mountainsTracksUseCase: MountainsTracksUseCase(mountainsTracksRepository: MountainsTracksRepository()), tracksUseCase: TracksUseCase(tracksRepository: TracksRepository()))
    
    var body: some View {
        Group {
            
            if viewModel.appIsLoading == true {
                
            }
            
           else if viewModel.userSession != nil {
               if (viewModelEmergency.emergencySessionActive || viewModel.isDone) && !viewModel.isAdmin { // harus cek sudah pilih tanggal belum
                    EmergencyProsesView(navigateViewModel: UserNavigateViewModel(fileName: viewModelEmergency.trackId))
                        .environmentObject(mountainViewModel)
                }
                else if viewModel.isAdmin {
                    AdminTabView(viewModel: viewModel)
                }
                else {
//                UserView(viewModel: viewModel)
                    UserTabView(viewModel: viewModel)
                        .environmentObject(navigationManager)
//                                MountainsTracksView(authViewModel: viewModel)
//                        .environmentObject(navigationManager)
////                                DueDateView()
                }
            }
//            else if viewModel.userSession != nil && viewModelEmergency.emergencySessionActive == false && !viewModel.isAdmin{
//                UserTabView(viewModel: viewModel)
//                    .environmentObject(navigationManager)
//            }
            else {
//                LoginView(viewModel: viewModel)
                LandingPageView(viewModel: viewModel)
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
//            print("usersession: \(String(describing: viewModel.userSession)) -- checking view: \(viewModelEmergency.emergencySessionActive) -- isDone: \(viewModel.isDone)")
            Task {
                await viewModel.fetchCurrentUser()
                viewModelEmergency.fetchEmergency()
                
                
            }
            
        }
        
    }
}
