//
//  CustomDirectionsCard.swift
//  Poentjak
//
//  Created by Felicia Himawan on 30/10/24.
//
import SwiftUI

enum DirectionCardStatus {
    case `default`, sos, overdue, sosSent
}

struct CustomDirectionsCard: View {
    var status: DirectionCardStatus
    var checkpointTitle: String = "Checkpoint 1"
    var etaText: String = "ETA 30-40 mins"
    var altitude: Int = 3000
    var overdueText: String = "30 mins left till overdue"
    var assignedRangers: [String] = []
    
    var time: Int = 70
    
    @State private var showInitialMessage = true
    
    var action: () -> Void // Add an action closure for tap gesture
    
    var body: some View {
        VStack(spacing: 12) {
            // Top part
            HStack(spacing: 8) {
                Image.LabelIcon.postSmall
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .center, spacing: 16) {
                        Text(checkpointTitle)
                            .font(.headlineRegular)
                            .foregroundColor(Color.primaryGreen500)
                        
                        Spacer()
                        
                        CustomLabelGeneral(type: .mdpl(altitude: altitude))
                    }
                    Text(etaText)
                        .font(.calloutRegular)
                        .foregroundColor(Color.primaryGreen500)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.primaryGreen500)
                    .bold()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Bottom part: Conditional display based on status
            if status != .default {
                Divider()
                    .background(Color.neutralGrayLightGray)
//                    .padding(.bottom, 8)
                
                
                if status == .overdue {
                    HStack {
                        Image(systemName: "clock.badge.exclamationmark.fill")
                            .foregroundColor(Color.customLabelsReminderIconRed)
                        
                        Text("You are overdue, **extend?**")
                            .font(.caption1Regular)
                            .foregroundColor(Color.customLabelsReminderTextRed)
                        
                    }
                    .padding(.horizontal, 72)
                    .padding(.vertical, 8)
                    .background(Color.customLabelsReminderBgRed)
                    .cornerRadius(4)
                }
                
                else if status == .sos {
                    HStack(spacing: 8) {
                        ZStack{
                            if showInitialMessage {
                                Text("Your SOS signal is being sent, stay calm.")
                                    .font(.subheadlineEmphasized)
                                    .foregroundColor(Color.primaryGreen500)
                            } else {
                                HStack(spacing: 10){
                                    Image.MapIcon.checkpoint
                                        .resizable()
                                        .frame(width: 29, height: 35)
                                    
                                    Text("Head to the nearest evacuation point if you can. If you can’t, stay where you are and wait for rescue.")
                                        .font(.subheadlineRegular)
                                        .foregroundColor(Color.primaryGreen500)
                                }
                            }
                        }
                        .transition(.opacity)
                        .animation(.easeInOut)
                    }
                    .padding(.bottom, 8)
                    .padding(.horizontal, 16)
                    
                }
                
                else if status == .sosSent {
                    HStack(spacing: 10){
                        Image("Icons/radar")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 32, height: 32)
                            .foregroundColor(Color.errorRed500)
                        
                        VStack(alignment: .leading) {
                            
                            if let firstRanger = assignedRangers.first {
                                Text("Ranger is on the way to **rescue you**")
                                    .font(.subheadlineRegular)
                                    .foregroundColor(Color.primaryGreen500)
                                HStack(spacing: 0) {
                                    Text("Ranger name: ")
                                        .font(.subheadlineRegular)
                                        .foregroundColor(Color.primaryGreen500)
                                    
                                    Text(firstRanger)
                                        .font(.subheadlineRegular)
                                        .foregroundColor(Color.primaryGreen500)
                                }
                            } else {
                                Text("A ranger is being assigned to your rescue, please wait a moment.")
                                    .font(.subheadlineRegular)
                                    .foregroundColor(Color.primaryGreen500)
                            }
                        }
                        
                        Spacer()
                        
                        
                        
                    }
                    .padding(.bottom, 8)
                    .padding(.horizontal, 16)
                }
                
                //                .padding(.bottom, 8)
                //                .padding(.horizontal, 16)
                
            } else {
                if (time > 0 && time <= 60){
                    Divider()
                        .background(Color.neutralGrayLightGray)
                    
                    
                    HStack {
                        Image(systemName: "clock.badge.exclamationmark.fill")
                            .foregroundColor(Color.customLabelsReminderIconRed)
                        
                        Text(time == 1 ? "1 min left till overdue, **extend?**" :"\(time) mins left till overdue, **extend?**")
                            .font(.caption1Regular)
                            .foregroundColor(Color.customLabelsReminderTextRed)
                    }
                    .padding(.horizontal, 50)
                    .padding(.vertical, 8)
                    .background(Color.customLabelsReminderBgRed)
                    .cornerRadius(4)
                }
                
            }
        }
        .frame(width: 340)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(16)
        .customShadow()
        .onTapGesture {
            action() // Call the action when the card is tapped
        }
        .onAppear {
            print("DEBUG CARD COMPONENT \(assignedRangers)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                showInitialMessage = false
                
            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                           time = 70
//                        }
        }
    }
}

// Update ParentView to use the clickable card with onTapGesture
struct ParentView: View {
    @State private var status: DirectionCardStatus = .overdue
    
    var body: some View {
        VStack(spacing: 20) {
            CustomDirectionsCard(
                status: status,
                checkpointTitle: "Pos 1",
                etaText: "ETA 30-45 mins",
                altitude: 2500,
                overdueText: "15 mins left till overdue",
                action: {
                    print("Card tapped!") // Define the action to perform on tap
                }
            )
            
            // Buttons to change status
            Button("Activate SOS") {
                status = .sos
            }
            .buttonStyle(.borderedProminent)
            
            Button("Activate SOS-Sent") {
                status = .sosSent
            }
            .buttonStyle(.borderedProminent)
            
            Button("Mark as Overdue") {
                status = .overdue
            }
            .buttonStyle(.borderedProminent)
            
            Button("Default") {
                status = .default
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ParentView()
}
