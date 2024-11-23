//
//  CustomCardGuideDetail.swift
//  Poentjak
//
//  Created by Felicia Himawan on 19/11/24.
//

import SwiftUI

struct CustomCardGuideDetail: View {
    var data: WiseGuideDataContent
    
    var body: some View {
        VStack{
            if let imageName = data.image {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 175)
                    .clipped()
                
            }
            
            Text(data.title)
                .font(.title2Emphasized)
                .foregroundColor(Color.primaryGreen500)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 16)
                .padding(.horizontal, 16)
            
            Text(.init(data.desc))
                .font(.calloutRegular)
                .foregroundColor(Color.primaryGreen500)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 16)
                .padding(.horizontal, 16)
        }
        .padding(.bottom, 24)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(16)
        .customShadow()
    }
}

#Preview {
    CustomCardGuideDetail(data: WiseGuideData.defaultData.content.first!)
}
