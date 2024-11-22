//
//  WiseGuideViewEmergency.swift
//  Poentjak
//
//  Created by Felicia Himawan on 21/11/24.
//

import SwiftUI

struct WiseGuideViewEmergency: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject var viewModel: EmergencyProsesViewModel
    
    var body: some View {
        ScrollView{
            VStack{
                
                HStack{
                    Text("Wise Guide")
                        .font(.title1Emphasized)
                        .foregroundColor(Color.primaryGreen500)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    if viewModel.isSignalSent && viewModel.sendSOSToFirebase || viewModel.isSignalSent && !viewModel.sendSOSToFirebase {
                        Button(action: {
                            navigationManager.navigationPath.append(DestinationView.soundBoard)
                        }) {
                            Image.SoundBoardIcon.whistle
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 22, height: 24)
                                .foregroundStyle(Color.neutralWhiteBiancaWhite)
                                .padding(8)
                                .background(Color.primaryGreen500)
                                .clipShape(Circle())
                        }
                    }
                    
                    //                    Button(action: {
                    //                        navigationManager.navigationPath.append(DestinationView.soundBoard)
                    //                    }) {
                    //                        Image.SoundBoardIcon.whistle
                    //                            .resizable()
                    //                            .renderingMode(.template)
                    //                            .frame(width: 22, height: 24)
                    //                            .foregroundStyle(Color.neutralWhiteBiancaWhite)
                    //                            .padding(8)
                    //                            .background(Color.primaryGreen500)
                    //                            .clipShape(Circle())
                    //                    }
                }
                .padding(.bottom, 16)
                
                
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
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                BackButtonComponent{
                    
                }
            }
        }
    }
}

#Preview {
    WiseGuideViewEmergency( viewModel: EmergencyProsesViewModel())
        .environmentObject(NavigationManager())
}
