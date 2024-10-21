//
//  UserTabView.swift
//  Poentjak
//
//  Created by Shan Havilah on 21/10/24.
//

// BELOM BISA DIPAKE, SEMENTARA SAMA KEK AdminTabView
// BARU BISA DIPAKE KALO UDH ADA VIEW YG BUAT DINAVIGATENYA


import SwiftUI

struct UserTabView: View {
    @StateObject var viewModel: AuthViewModel // nanti ganti
    @State private var selectedTab = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab){
            
            ActiveEmergencyView(authViewModel: viewModel) // nanti ganti
                .tabItem {
                    VStack {
                        Image.TabBarIcon.magnifier
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 0 ? Color.primaryGreen500 : Color.customTabBarDisabledText)

                        Text("Explore")
                            .foregroundColor(selectedTab == 0 ? Color.primaryGreen500 : Color.customTabBarDisabledText)
                            .font(.customTabTitle)
                    }

                }
                .onAppear{
                    selectedTab = 0
                }
                .tag(0)
            
//            ControlPanelView()
            ActiveHikersView() // nanti ganti
                .tabItem {
                    VStack {
                        Image.TabBarIcon.book
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 1 ? Color.primaryGreen500 : Color.customTabBarDisabledText)

                        Text("Guide")
                            .foregroundColor(selectedTab == 1 ? Color.primaryGreen500 : Color.customTabBarDisabledText)
                            .font(.customTabTitle)
                    }

                }
                .onAppear{
                    selectedTab = 1
                }
                .tag(1)
                    
        }
        
        .accentColor(Color.primaryGreen500)
                
    }
}

//#Preview {
//    UserTabView()
//}
