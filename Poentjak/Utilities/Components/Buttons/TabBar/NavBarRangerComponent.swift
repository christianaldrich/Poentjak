//
//  NavBarRangerComponent.swift
//  Poentjak
//
//  Created by Shan Havilah on 20/10/24.
//

import SwiftUI

struct NavBarRangerComponent: View {
    var tabType: TabBarState
    //var action: () -> Void
    
    var body: some View {
        Divider()
        HStack {
            Spacer()
            
            Button{
                
            } label:  {
                VStack {
                    Image.TabBarIcon.sos
                        .renderingMode(.template)
                        .foregroundColor(tabType == .emergency ? Color.errorRed500 : .customTabBarDisabledText)
                        .font(.title3Emphasized)
                    
                    Text("Emergency")
                        .foregroundColor(tabType == .emergency ? Color.primaryGreen500 : .customTabBarDisabledText)
                        .font(.customTabTitle)
                        .padding(.top, 1)
                }
            }
            
            Spacer()
            
            Button{
                
            } label:  {
                VStack {
                    Image.TabBarIcon.controlPanel
                        .renderingMode(.template) // This allows the icon to be tinted
                        .foregroundColor(tabType == .controlPanel ? Color.primaryGreen500 : .customTabBarDisabledText)
                    
                    Text("Control Panel")
                        .foregroundColor(tabType == .controlPanel ? Color.primaryGreen500 : .customTabBarDisabledText)
                        .font(.customTabTitle)
                        //.padding(.top, 1)
                }
            }
            
            Spacer()
        }
        .frame(width: 390, height: 51)
//        .padding()
        .background(Color.white)

    }
}

#Preview {
    NavBarRangerComponent(tabType: .emergency)
    NavBarRangerComponent(tabType: .controlPanel)
}
