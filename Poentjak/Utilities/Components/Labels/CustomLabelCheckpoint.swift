//
//  CustomLabelHiker.swift
//  Poentjak
//
//  Created by Felicia Himawan on 19/10/24.
//


enum LabelCheckpoint {
    case post
    case summit
    case emergency
    
    var iconName: Image {
        switch self {
        case .post:
            return Image.LabelIcon.post
        case .summit:
            return Image.LabelIcon.summit
        case .emergency:
            return Image.LabelIcon.postBig
        }
    }
}

import SwiftUI

struct CustomLabelCheckpoint: View {
    var labelType: LabelCheckpoint
    let checkpointTitle: String
    let fromCheckpoint: String
    let etaDuration: String
    let etaUnit: String
    let altitude: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                labelType.iconName
                    .padding(.trailing, 24)
                
                VStack(alignment: .leading) {
                    Text(checkpointTitle)
                        .font(.headlineRegular)
                        .foregroundStyle(Color.primaryGreen500)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 2)
                    
                    Text("ETA ")
                        .font(.footnoteRegular)
                        .foregroundStyle(Color.primaryGreen500)
                    +
                    Text(etaDuration)
                        .font(.footnoteEmphasizedBold)
                        .foregroundStyle(Color.primaryGreen500)
                    +
                    Text(" \(etaUnit) from ")
                        .font(.footnoteRegular)
                        .foregroundStyle(Color.primaryGreen500)
                    +
                    Text("\(fromCheckpoint)")
                        .font(.footnoteRegular)
                        .foregroundStyle(Color.neutralGrayTertiaryGray)
                }
            }
            .frame(maxWidth: 341, alignment: .leading)
            .padding(.vertical, 2)
            .overlay(
                CustomLabelGeneral(type: .mdplCheckpoint(altitude: Int(altitude))),
                alignment: .topTrailing
            )
            
//            Rectangle()
//                .fill(Color.neutralGrayLightGray)
//                .frame(width: 366, height: 0.98)
        }
        
    }
}

#Preview {
    CustomLabelCheckpoint(labelType: .summit, checkpointTitle: "Checkpoint 2", fromCheckpoint: "Chekpoint 1", etaDuration: "30-40", etaUnit: "mins", altitude: 200)
}
