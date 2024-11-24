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
    @StateObject var viewModel: AuthViewModel
    @State private var selectedTab = 0
    @StateObject var navigationManager = NavigationManager()
    
    var body: some View {
        
        TabView(selection: $selectedTab){
            Group{
                
                MountainsTracksView(authViewModel: viewModel)
                    .environmentObject(navigationManager)
                
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
                
                WiseGuideViewHome()
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
                
//                ActiveHikersView(viewModel: ActiveHikersViewModel(activeHikersUseCase: ActiveHikersUseCase(activeHikersRepository: ActiveHikersRepository(), userRepository: DefaultUserRepository())), authViewModel: viewModel)
//                    .tabItem {
//                        VStack {
//                            Image.TabBarIcon.book
//                                .renderingMode(.template)
//                                .foregroundColor(selectedTab == 1 ? Color.primaryGreen500 : Color.customTabBarDisabledText)
//                            
//                            Text("Guide")
//                                .foregroundColor(selectedTab == 1 ? Color.primaryGreen500 : Color.customTabBarDisabledText)
//                                .font(.customTabTitle)
//                        }
//                        
//                    }
//                    .onAppear{
//                        selectedTab = 1
//                    }
//                    .tag(1)
            }
            .toolbarBackground(Color.neutralWhite, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            
        }
        .onAppear{
            print("user tab view -> usersession: \(String(describing: viewModel.userSession)) -- ")
        }
        
        
        .accentColor(Color.primaryGreen500)
        
        
        
    }
}

//#Preview {
//    UserTabView()
//}
