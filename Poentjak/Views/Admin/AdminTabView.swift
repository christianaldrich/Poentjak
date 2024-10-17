//
//  AdminTabView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 26/09/24.
//


import SwiftUI

struct AdminTabView: View {
    
    @StateObject var viewModel: AuthViewModel
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            let authViewModel = DIContainer().makeAdminEmergencyViewModel()
//            AdminEmergencyDetailView(viewModel: authViewModel, emergencyRequestId: "0x78aq8JdEKlVvofzx1R")
//            RangerView()
            
            ActiveEmergencyView(authViewModel: viewModel)

                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }
                .onAppear{
                    selectedTab = 0
                }
                .tag(0)
            
//            ControlPanelView()
            ActiveHikersView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                }
                .onAppear{
                    selectedTab = 1
                }
                .tag(1)
            
           
            
                    
            
        }
                
    }

}

#Preview {
    AdminView()
}
