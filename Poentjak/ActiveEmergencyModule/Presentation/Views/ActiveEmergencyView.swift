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
                
                HikersNeedHelpSectionComponent(hikers: viewModel.hiker){ hiker in
                    viewModel.rescuing(id: hiker.id)
                    selectedUser = hiker
                    isDetailViewActive = true
                    
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