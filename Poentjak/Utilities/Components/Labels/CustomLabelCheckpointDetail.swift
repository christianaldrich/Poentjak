//
//  CustomLabelCheckpointDetail.swift
//  Poentjak
//
//  Created by Shan Havilah on 02/11/24.
//

import SwiftUI

struct CustomLabelCheckpointDetail: View {
    let checkPointTitle: String
    let checkPointName: String
    let checkPointDesc: String
    let mdpl: Double
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("\(checkPointTitle)")
                    .font(.footnoteRegular)
                    .bold()
                    .foregroundColor(Color.primaryGreen500)
                Spacer()
                CustomLabelGeneral(type: .mdplCheckpointTapped(altitude: Int(mdpl)))
            }
            Text("\(checkPointName)")
                .font(.title2Regular)
                .bold()
                .foregroundColor(Color.primaryGreen500)
                .padding(.bottom, 1)
            Text("\(checkPointDesc)")
                .font(.footnoteRegular)
                .foregroundColor(Color.primaryGreen500)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: 341, maxHeight: 84)
    }
}

#Preview {
    CustomLabelCheckpointDetail(checkPointTitle: "Checkpoint 1", checkPointName: "Simpang maleber", checkPointDesc: "Ini simpang", mdpl: 2345)
}
