//
//  CustomCardGuideDetail.swift
//  Poentjak
//
//  Created by Felicia Himawan on 19/11/24.
//

import SwiftUI

struct CustomCardGuideDetail: View {
    var data: WiseGuideDataContent
    //    var image: Image?
    //    var title: String
    //    var desc: Text
    //
    var body: some View {
        VStack(alignment: .leading) {
            if let imageName = data.image {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 175)
                    .clipped()
            }
            
            Text(data.title)
                .font(.title2Emphasized)
                .foregroundColor(Color.primaryGreen500)
                .padding(.top, 16)
                .padding(.horizontal, 16)
            
            
            Text(data.desc)
                .font(.calloutRegular)
                .foregroundColor(Color.primaryGreen500)
                .padding(.vertical, 16)
                .padding(.horizontal, 16)
        }
        .padding(.bottom, 24)
        .frame(width: 340)
        .background(Color.white)
        .cornerRadius(16)
        .customShadow()
    }
}

#Preview {
    CustomCardGuideDetail(data: WiseGuideData.defaultData.content.first!)
//    CustomCardGuideDetail(
//        image: Image("WiseGuide/wiseGuide1"),
//        title: "The must-bring blanket",
//        desc: Text("**• 3 seconds**: time to make a **decision**\n**• 3 minutes**: brain’s limit without **oxygen**\n**• 3 hours**: survival in extreme weather unprotected\n• 3 days: survival without water\n• 3 weeks: survival without food")
//    )
//    
//    CustomCardGuideDetail(
//        title: "What is hypothermia?",
//        desc: Text("Hypothermia is a dangerous drop in body temperature below 35C\n*normal body temperature is around 37C")
//    )
}
