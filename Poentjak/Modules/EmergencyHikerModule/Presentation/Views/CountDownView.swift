//
//  CountDownView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 11/10/24.
//

import SwiftUI

struct CountDownView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject var viewModel: EmergencyProsesViewModel
    
    @State private var pulseAnimation1 = false
    @State private var pulseAnimation2 = false
    
    var body: some View {
        VStack{
            Text("Alerting Rangers in...")
                .font(.title3Emphasized)
                .foregroundColor(Color.primaryGreen500)
                .padding(.top, 84)
//            Text("This is the emergency type you chose: \(viewModel.emergencyType)")
//                .font(.title)
//                .padding()
            
            Spacer()
            
            ZStack{
                Circle()
                    .fill(Color.accentRedSos)
                    .frame(width: 262, height: 262)
                    .overlay(
                        Text("\(viewModel.countDownTime)")
                            .font(.customCountDown)
                            .foregroundColor(.white)
                    )
                
                if viewModel.countDownTime > 0 {
                    Circle()
                        .stroke(Color.accentRedSos, lineWidth: 2)
                        .frame(width: 326, height: 326)
                        .scaleEffect(pulseAnimation1 ? 1.2 : 1.0)
                        .opacity(pulseAnimation1 ? 0.0 : 0.5)
                        .animation(Animation.easeOut(duration: 1).repeatForever(autoreverses: false), value: pulseAnimation1)
                        .onAppear {
                            pulseAnimation1 = true
                        }
                    
                    Circle()
                        .stroke(Color.accentRedSos.opacity(0.5), lineWidth: 2)
                        .frame(width: 403, height: 403)
                        .scaleEffect(pulseAnimation2 ? 1.4 : 1.0)
                        .opacity(pulseAnimation2 ? 0.0 : 0.3)
                        .animation(Animation.easeOut(duration: 1).repeatForever(autoreverses: false), value: pulseAnimation2)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                pulseAnimation2 = true
                            }
                        }
                }
            }
            
            Spacer()
            
            SlideToActionButton(
                slidingDirection: .rtl, text: "Slide to cancel", onActionCompleted: {
                    viewModel.cancelCountDown()
                    navigationManager.popToRoot()
                }
            )
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
            
            
        }
        .onAppear{
            viewModel.startCountDown(navigationManager: navigationManager)
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    CountDownView(viewModel: EmergencyProsesViewModel())
        .environmentObject(NavigationManager())
    
}
