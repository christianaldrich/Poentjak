//
//  CustomLabelHiker.swift
//  Poentjak
//
//  Created by Felicia Himawan on 19/10/24.
//

import SwiftUI

struct CustomLabelCheckpoint: View {
    let checkpointTitle: String
    let fromCheckpoint: String
    let etaDuration: String
    let etaUnit: String
    let altitude: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Image.LabelIcon.postBig
                    .padding(.trailing, 24)
                
                VStack(alignment: .leading) {
                    Text(checkpointTitle)
                        .font(.headlineRegular)
                        .foregroundStyle(Color.primaryGreen500)
                    
                    Text("From \(fromCheckpoint)")
                        .font(.footnoteRegular)
                        .foregroundStyle(Color.neutralGrayTertiaryGray)
                        .padding(.bottom, 4)
                    
                    Text("Estimated ETA ")
                        .font(.footnoteRegular)
                        .foregroundStyle(Color.primaryGreen500)
                    +
                    Text(etaDuration)
                        .font(.footnoteEmphasizedBold)
                        .foregroundStyle(Color.primaryGreen500)
                    +
                    Text(" \(etaUnit) from \(fromCheckpoint)")
                        .font(.footnoteRegular)
                        .foregroundStyle(Color.primaryGreen500)
                    
                }
            }
            .frame(maxWidth: 320, alignment: .leading)
            .overlay(
                CustomLabelGeneral(type: .mdpl(altitude: altitude)),
                alignment: .topTrailing
            )
            
            Rectangle()
                .fill(Color.neutralGrayLightGray)
                .frame(width: 366, height: 0.98)
        }
        
    }
}

#Preview {
    CustomLabelCheckpoint(checkpointTitle: "Checkpoint 2", fromCheckpoint: "Chekpoint 1", etaDuration: "30-40", etaUnit: "mins", altitude: 200)
}
