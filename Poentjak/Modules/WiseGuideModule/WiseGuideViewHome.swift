//
//  WiseGuideView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 20/11/24.
//

import SwiftUI

struct WiseGuideViewHome: View {
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Text("Wise Guide")
                        .font(.title1Emphasized)
                        .foregroundColor(Color.primaryGreen500)
                        .padding(.bottom, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
//                    HStack{
//                        Image(systemName: "checklist.checked")
//                            .font(.bodyEmphasized)
//                            .foregroundColor(Color.primaryGreen500)
//                            .padding(.trailing, 2)
//                        
//                        Text("Must bring checklist")
//                            .font(.subheadlineRegular)
//                            .foregroundColor(Color.primaryGreen500)
//                        
//                        Spacer()
//                        
//                        Image(systemName: "chevron.right")
//                            .font(.bodyEmphasized)
//                            .foregroundColor(Color.primaryGreen500)
//                        
//                    }
//                    .padding(.horizontal, 16)
//                    .padding(.vertical, 16)
//                    .background(
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(Color.accentGreenlabel)
//                    )
//                    .padding(.vertical, 20)
//                    
                    
                    
                    
                    Text("Be aware of these common emergencies")
                        .font(.bodyEmphasized)
                        .foregroundColor(Color.primaryGreen500)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 16){
                        CustomCardGuideComponent(
                            data: WiseGuideData.data["lost"] ?? WiseGuideData.defaultData
                        )
                        
                        CustomCardGuideComponent(
                            data: WiseGuideData.data["hipo"] ?? WiseGuideData.defaultData
                        )
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                    
                    Text("Survival tips")
                        .font(.bodyEmphasized)
                        .foregroundColor(Color.primaryGreen500)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 16){
                        CustomCardGuideComponent(
                            data: WiseGuideData.data["tips"] ?? WiseGuideData.defaultData
                        )
                        
                        CustomCardGuideComponent(
                            data: WiseGuideData.data["animal"] ?? WiseGuideData.defaultData
                        )
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                    
                    Text("Important to know")
                        .font(.bodyEmphasized)
                        .foregroundColor(Color.primaryGreen500)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 16){
                        CustomCardGuideComponent(
                            data: WiseGuideData.data["camping"] ?? WiseGuideData.defaultData
                        )
                        
                        CustomCardGuideComponent(
                            data: WiseGuideData.data["injury"] ?? WiseGuideData.defaultData
                        )
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                    
                    
                }
                .padding(.top, 8)
                .padding(.bottom, 16)
                .padding(.horizontal, 24)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    WiseGuideViewHome()
}

