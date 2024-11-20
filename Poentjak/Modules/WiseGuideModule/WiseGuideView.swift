//
//  WiseGuideView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 20/11/24.
//

import SwiftUI

struct WiseGuideView: View {
    
    var body: some View {
//        NavigationStack{
            ScrollView{
                VStack(alignment: .leading){
                    Text("Be aware of these common emergencies")
                    
                    HStack(spacing: 16){
                        CustomCardGuideComponent(
                            data: WiseGuideData.data["lost"] ?? WiseGuideData.defaultData
                        )
                        
                        CustomCardGuideComponent(
                            data: WiseGuideData.data["hipo"] ?? WiseGuideData.defaultData
                        )
                    }
                    .padding(.top, 4)
                    .padding(.bottom, 24)
                    
                    Text("Survival tips")
                    
                    
                }
                .padding(.top, 82)
                .padding(.bottom, 16)
            }
        }
//    }
}

#Preview {
    WiseGuideView()
}
