//
//  ContentView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 23/09/24.
//

import SwiftUI

struct ActiveEmergencyView: View {
    @StateObject private var viewModel = UserViewModel()
    //    @State private var activeEmergencies = [UserModel]()
    //    let hikers
    
    @State var selectedUser: EmergencyRequestModel?
    @State private var isDetailViewActive = false
    
    
    var body: some View {
        
        NavigationView {
            List {
                
                HikersNeedHelpSectionComponent(hikers: viewModel.hiker, users: viewModel.user){ hiker in
                    viewModel.rescuing(id: hiker.id)
                    selectedUser = hiker
                    isDetailViewActive = true
                    viewModel.fetchHikerInfo(id: hiker.id)
                    
                }
                
                RangerRescuingSectionComponent(hikers: viewModel.hiker){
                    hiker in
                    viewModel.rescuing(id: hiker.id)
                    selectedUser = hiker
                    isDetailViewActive = true
                }
                
            }
            .navigationTitle("Active Emergencies")
            
            .onAppear {
                viewModel.fetchDangerHiker()
                //                viewModel.fetchEmergency()
                //                viewModel.fetchHikerInfo(id: "user1")
                
                viewModel.fetchHikerInfo(id: "9nL11jCqOUcv63wmfX8G8KJTkB82")
                //                if !viewModel.hiker.isEmpty {
                //                    for hiker in viewModel.hiker {
                //                        print("Fetching info for hiker with id: \(hiker.id)")
                //                        viewModel.fetchHikerInfo(id: hiker.id) // Fetch info for each hiker
                //                    }
                //                } else {
                //                    print("No hikers found in the view model")
                //                }
                //
            }
            .background(
                NavigationLink(
                    destination: RangerReceiveSOSAlertView(hikers: selectedUser),
                    isActive: $isDetailViewActive,
                    label: { EmptyView() }
                )
            )
            
        }
        .ignoresSafeArea()
        
        
        
    }
    
}

#Preview {
    ActiveEmergencyView()
}
