//
//  CustomDirectionsCard.swift
//  Poentjak
//
//  Created by Felicia Himawan on 30/10/24.
//
import SwiftUI

enum DirectionCardStatus {
    case `default`, sos, overdue
}

struct CustomDirectionsCard: View {
    var status: DirectionCardStatus
    var checkpointTitle: String = "Checkpoint 1"
    var etaText: String = "ETA 30-40 mins"
    var altitude: Int = 3000
    var overdueText: String = "30 mins left till overdue"
    
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
                            .font(.caption1RegularCustom)
                            .foregroundColor(Color.primaryGreen500)
                        
                        Spacer()
                        
                        CustomLabelGeneral(type: .mdpl(altitude: altitude))
                    }
                    Text(etaText)
                        .font(.caption1Regular)
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
                    .padding(.bottom, 8)
                
                HStack(spacing: 8) {
                    if status == .overdue {
                        HStack {
                            Image(systemName: "clock.badge.exclamationmark.fill")
                                .foregroundColor(Color.customLabelsReminderIconRed)
                            
                            Text(overdueText)
                                .font(.caption1Regular)
                                .foregroundColor(Color.customLabelsReminderTextRed)
                            +
                            Text(", extend?")
                                .font(.caption1Emphasized)
                                .foregroundColor(Color.customLabelsReminderTextRed)
                        }
                        .padding(.horizontal, 50)
                        .padding(.vertical, 8)
                        .background(Color.customLabelsReminderBgRed)
                        .cornerRadius(4)
                    }
                    
                    if status == .sos {
                        Text("Your SOS signal is being sent, stay calm.")
                            .font(.subheadlineEmphasized)
                            .foregroundColor(Color.primaryGreen500)
                    }
                }
                .padding(.bottom, 16)
                .padding(.horizontal, 8)
            }
        }
        .frame(width: 340)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 2)
        .shadow(color: .black.opacity(0.02), radius: 3, x: 0, y: 0)
        .onTapGesture {
            action() // Call the action when the card is tapped
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
