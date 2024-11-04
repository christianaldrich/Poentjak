//
//  DisclaimerTrackCardComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 04/11/24.
//

import SwiftUI

struct DisclaimerTrackCardComponent: View {
    var body: some View {
        VStack{
            Text("Disclaimer")
                .font(.title2Emphasized)
            
            Image("disclaimer")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 303, height: 194)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            VStack{
                Text("Bring a powerbank!")
                    .font(.title3Emphasized)
                
                Text("For the best app-usage, don’t forget to bring\na powerbank so you have enough battery to\nlast your hike. 80% of your battery is lost\nwhen hiking down.")
                    .font(.subheadlineRegular)
            }
            
        }
    }
}

#Preview {
    DisclaimerTrackCardComponent()
}
