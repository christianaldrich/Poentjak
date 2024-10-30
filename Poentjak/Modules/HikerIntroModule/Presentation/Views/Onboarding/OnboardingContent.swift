//
//  OnboardingContent.swift
//  Poentjak
//
//  Created by Felicia Himawan on 29/10/24.
//

import SwiftUI

struct OnboardingContent: View {
    var data: OnboardingData
    
    var body: some View {
        VStack{
            
            ZStack {
                Color.clear

                Image(data.backgroundImage)
                
            }
            .frame(height: 445)
            .padding(.horizontal, 25)
            
            Text(data.primaryText)
                .font(.title1Emphasized)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.primaryGreen500)
                .padding(.bottom, 8)
            //                .background(Color.red)
            
            Text(data.secondaryText)
                .font(.bodyRegular)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.black)
            //                .background(Color.red)
            
        }
        .padding(.horizontal, 25)
    }
}

#Preview {
    OnboardingContent(data: OnboardingData.sample)
}
