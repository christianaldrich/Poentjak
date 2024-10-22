//
//  TabBarComponent.swift
//  Poentjak
//
//  Created by Shan Havilah on 20/10/24.
//

import SwiftUI

struct CustomTabBarComponent: View {
    var tabType: TabBarState
    //var action: () -> Void
    
    var body: some View {
        Divider()
        HStack {
            Spacer()
            
            Button {
                
            } label: {
                VStack {
                    Image.TabBarIcon.magnifier
                        .renderingMode(.template)
                        .foregroundColor(tabType == .explore ? Color.primaryGreen500 : .customTabBarDisabledText)
                    
                    Text("Explore")
                        .foregroundColor(tabType == .explore ? Color.primaryGreen500 : .customTabBarDisabledText)
                         .font(.customTabTitle)
                }
            }
            .padding(.bottom, 40)
            
            Spacer()
            
            Button {
                
            } label: {
                VStack {
                    Image.TabBarIcon.book
                        .renderingMode(.template)
                        .foregroundColor(tabType == .guide ? Color.primaryGreen500 : .customTabBarDisabledText)
                    
                    Text("Guide")
                        .foregroundColor(tabType == .guide ? Color.primaryGreen500 : .customTabBarDisabledText)
                        .font(.customTabTitle)
                }
            }
            .padding(.bottom, 40)
            
            Spacer()
        }
        .frame(width: 393, height: 83)
        //.padding()
        .background(Color.white)

    }
}

#Preview {
    VStack {
        CustomTabBarComponent(tabType: .guide)
        CustomTabBarComponent(tabType: .explore)
    }
}
