//
//  ContentView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 23/09/24.
//

import SwiftUI

struct ActiveEmergencyView: View {
    @StateObject private var viewModel = UserViewModel(activeEmergencyUseCase: ActiveEmergencyUseCase(activeEmergencyRepository: ActiveEmergencyRepository(), userRepository: DefaultUserRepository()))
    //    @State private var activeEmergencies = [UserModel]()
    //    let hikers
    
    @State var selectedUser: EmergencyRequestModel?
    @State private var isDetailViewActive = false
    @State private var idContainer: String = ""
    @StateObject var authViewModel: AuthViewModel
    
    var body: some View {
        
            List {
                
                
                
                HikersNeedHelpSectionComponent(hikers: viewModel.hiker){ hiker in
                    viewModel.rescuing(id: hiker.id)
                    selectedUser = hiker
                    idContainer = hiker.id
                    isDetailViewActive = true
                    
                }
                
                RangerRescuingSectionComponent(hikers: viewModel.hiker){
                    hiker in
//                    viewModel.rescuing(id: hiker.id)
                    selectedUser = hiker
                    idContainer = hiker.id
                    isDetailViewActive = true
                }
                Button(action: {
                    Task {
                        await authViewModel.signOut()
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
            .navigationTitle("Active Emergencies")
            
            .onAppear {
                viewModel.fetchActiveEmergencyByTrack()
//                viewModel.fetchDangerHiker()
                viewModel.startTimer()
            }
            .onDisappear {
                viewModel.stopTimer()
            }
            .background(
                NavigationLink(
                    destination: AdminEmergencyDetailView(viewModel:DIContainer().makeAdminEmergencyViewModel(), mapViewModel: RangerMapViewModel(fileName: selectedUser?.user?.trackId ?? "gede1") ,emergencyRequestId: idContainer),
                    isActive: $isDetailViewActive,
                    label: { EmptyView() }
                )
            )
            
        
        
        
        
    }
    
}

//#Preview {
//    ActiveEmergencyView()
//}
