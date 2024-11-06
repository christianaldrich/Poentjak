//
//  AlertGuideView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 09/10/24.
//

import SwiftUI

struct AlertGuideView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject var viewModel: EmergencyProsesViewModel
    @StateObject var viewModelAlert = AlertGuideTestingViewModel()
    
    var body: some View {
        VStack {
            
            topNavigationBar
                .padding(.bottom, 32)
            
            //            Spacer()
            //            Text("this is the guide")
            //
            //            Text("You chose this emergency type: \(viewModel.emergencyType)")
            
            AlertGuideTabBar(idSelected: $viewModel.idSelected, text: viewModel.text)
            AlertGuideContent(contentData: viewModel.contentData)
            
            Text("You chose this emergency type: \(viewModel.emergencyType)")
            
            
            Spacer()
            
//            bottomActionButtons
            HStack(spacing: 8) {
                Button(action: {
                    viewModel.idSelected -= 1
                }) {
                    Image(systemName: "chevron.left")
                        .font(.bodyEmphasized)
                        .foregroundStyle(Color.neutralWhiteBiancaWhite)
                        .padding(16)
                        .background(Color.primaryGreen500)
                        .cornerRadius(16)
                }
                .opacity(viewModel.idSelected == 1 ? 0 : 1)
                .disabled(viewModel.idSelected == 1)
                
                
                Button(action: {
                    navigationManager.navigationPath.append(DestinationView.countDown)
                }) {
                    Text("Alert Ranger")
                        .font(.title3Emphasized)
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 58)
                }
                .background(Color.accentRedSos)
                .cornerRadius(16)
                
                Button(action: {
                    viewModel.idSelected += 1
                }) {
                    Image(systemName: "chevron.right")
                        .font(.bodyEmphasized)
                        .foregroundStyle(Color.neutralWhiteBiancaWhite)
                        .padding(16)
                        .background(Color.primaryGreen500)
                        .cornerRadius(16)
                }
                .opacity(viewModel.idSelected == 4 ? 0 : 1)
                .disabled(viewModel.idSelected == 4)
                
            }
            
            
            //            Button("Alert Ranger") {
            //                navigationManager.navigationPath.append(DestinationView.countDown)
            //            }
            //            .frame(maxWidth: .infinity, maxHeight: 50)
            //            .backgroundStyle(Color.accentRedSos)
            //            .foregroundColor(.white)
            //            .cornerRadius(16)
            
            //            Button("Open Sound Board") {
            //                navigationManager.navigationPath.append(DestinationView.soundBoard)
            //            }
            //            .frame(maxWidth: .infinity, maxHeight: 50)
            //            .background(Color.blue)
            //            .foregroundColor(.white)
            //            .cornerRadius(8)
            //            .padding()
            
            
            //            Button("Cancel") {
            //                navigationManager.popToRoot()
            //            }
            //            .frame(maxWidth: .infinity, maxHeight: 50)
            //            .background(Color.orange)
            //            .foregroundColor(.white)
            //            .cornerRadius(8)
            //            .padding()
            
            
        }
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal, 24)
        
        
    }
}

// MARK: - Extension View
extension AlertGuideView {
    var topNavigationBar: some View {
        HStack {
            Button(action: {
                navigationManager.popToRoot()
            }) {
                Text("Cancel")
                    .font(.title3Emphasized)
                    .foregroundColor(.errorRed500)
            }
            
            Spacer()
            
            Button(action: {
                navigationManager.navigationPath.append(DestinationView.soundBoard)
            }) {
                Image.SoundBoardIcon.whistle
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.neutralWhiteBiancaWhite)
                    .padding(8)
                    .background(Color.primaryGreen500)
                    .clipShape(Circle())
            }
        }
    }
    
    var bottomActionButtons: some View {
        HStack(spacing: 8) {
            Button(action: {
                viewModel.idSelected -= 1
            }) {
                Image(systemName: "chevron.left")
                    .font(.bodyEmphasized)
                    .foregroundStyle(Color.neutralWhiteBiancaWhite)
                    .padding(16)
                    .background(Color.primaryGreen500)
                    .cornerRadius(16)
            }
            .opacity(viewModelAlert.idSelected == 1 ? 0 : 1)
            .disabled(viewModelAlert.idSelected == 1)
            
            
            Button(action: {
                navigationManager.navigationPath.append(DestinationView.countDown)
            }) {
                Text("Alert Ranger")
                    .font(.title3Emphasized)
                    .foregroundColor(.white)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 58)
            }
            .background(Color.accentRedSos)
            .cornerRadius(16)
            
            Button(action: {
                viewModel.idSelected += 1
            }) {
                Image(systemName: "chevron.right")
                    .font(.bodyEmphasized)
                    .foregroundStyle(Color.neutralWhiteBiancaWhite)
                    .padding(16)
                    .background(Color.primaryGreen500)
                    .cornerRadius(16)
            }
            .opacity(viewModelAlert.idSelected == 4 ? 0 : 1)
            .disabled(viewModelAlert.idSelected == 4)
            
        }
    }
}


#Preview {
    AlertGuideView(viewModel: EmergencyProsesViewModel())
        .environmentObject(NavigationManager())
}
