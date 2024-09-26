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
            
            EmergencyView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }
                .onAppear{
                    selectedTab = 0
                }
                .tag(0)
            
            ControlPanelView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                }
                .onAppear{
                    selectedTab = 1
                }
                .tag(1)
            
            RangerSettingsView()
        
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                }
                .onAppear{
                    selectedTab = 2
                }
                .tag(2)
            
            
                    
            
        }
                
    }

}

#Preview {
    AdminView()
}
