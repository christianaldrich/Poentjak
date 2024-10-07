//
//  ContentView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 23/09/24.
//

import SwiftUI

struct ActiveEmergencyView: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var activeEmergencies = [UserModel]()
    
    @State var selectedUser: UserModel?
    @State private var isDetailViewActive = false
    
    
    var body: some View {
        
        NavigationView {
            List {
                
                HikersNeedHelpSectionComponent(users: viewModel.user.filter{!$0.isInRescue}){ user in
                    viewModel.rescuing(id: user.id)
                    selectedUser = user
                    isDetailViewActive = true
                }
                
                RangerRescuingSectionComponent(users: viewModel.user.filter{$0.isInRescue}){
                    user in
                    viewModel.rescuing(id: user.id)
                    selectedUser = user
                    isDetailViewActive = true
                }
                
            }
            .navigationTitle("Active Emergencies")
            
            .onAppear {
                viewModel.fetchEmergency()
            }
            .background(
                NavigationLink(
                    destination: RangerReceiveSOSAlertView(user: selectedUser),
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
