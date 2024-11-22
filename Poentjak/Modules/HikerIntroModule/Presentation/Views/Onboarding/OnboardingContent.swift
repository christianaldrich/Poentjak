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
            .frame(height: UIScreen.main.bounds.height / 2.2)
            .padding(.horizontal, 24)
            //.border(.red)
            
            Text(data.primaryText)
                .font(.title1Emphasized)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.primaryGreen500)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 8)
            
            Text(data.secondaryText)
                .font(.bodyRegular)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(Color.black)
            
        }
        .padding(.horizontal, 25)
    }
}

#Preview {
    OnboardingContent(data: OnboardingData.sample)
}
