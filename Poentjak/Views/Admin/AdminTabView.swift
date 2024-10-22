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
        NavigationView {
            
            TabView(selection: $selectedTab){
                let authViewModel = DIContainer().makeAdminEmergencyViewModel()
                //            AdminEmergencyDetailView(viewModel: authViewModel, emergencyRequestId: "0x78aq8JdEKlVvofzx1R")
                //            RangerView()
                
                ActiveEmergencyView(authViewModel: viewModel)
                    .tabItem {
                        VStack {
                            Image.TabBarIcon.sos
                                .renderingMode(.template)
                                .foregroundColor(selectedTab == 0 ? Color.errorRed500 : Color.customTabBarDisabledText)
                            //                            .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                            Text("Emergency")
                                .foregroundColor(selectedTab == 0 ? Color.primaryGreen500 : Color.customTabBarDisabledText)
                                .font(.customTabTitle)
                        }
                        
                        .onAppear{
                            selectedTab = 0
                        }
                        .tag(0)
                    }
                //            ControlPanelView()
                ActiveHikersView()
                    .tabItem {
                        VStack {
                            Image.TabBarIcon.controlPanel
                                .renderingMode(.template)
                                .foregroundColor(selectedTab == 1 ? Color.primaryGreen500 : Color.customTabBarDisabledText)
                            //                            .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                            Text("Control Panel")
                                .foregroundColor(selectedTab == 1 ? Color.primaryGreen500 : Color.customTabBarDisabledText)
                                .font(.customTabTitle)
                        }
                        .onAppear{
                            selectedTab = 1
                        }
                        .tag(1)
                        
                    }
                
                    
                
                
                
                
                
            }
            .accentColor(Color.primaryGreen500)
        }
    }
    
}


#Preview {
    AdminView()
}
