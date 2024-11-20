//
//  WiseGuideDetailView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 20/11/24.
//

import SwiftUI

struct WiseGuideDetailView: View {
    var data: WiseGuideDataModel
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 16) {
                Image(data.sqaureImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(16)
                
                Text(data.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                ForEach(data.content){content in
                    CustomCardGuideDetail(data: content)
                        }

                
                
            }
            .padding()
        }
    }
}

#Preview {
    WiseGuideDetailView(data: WiseGuideData.defaultData)
}
