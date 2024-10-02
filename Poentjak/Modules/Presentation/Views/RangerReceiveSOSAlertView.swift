//
//  RangerReceiveSOSAlertView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 01/10/24.
//
import SwiftUI

struct RangerReceiveSOSAlertView: View{
    
    let user: UserModel?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                if let user = user {
                    Text("ID: \(user.id)")
                    Text("Name: \(user.name)")
                    Text("Age: \(user.age)")
                    Text("Gender: \(user.gender)")
                    Text("Height: \(user.height)")
                    Text("Weight: \(user.weight)")
                    Text("Is in Danger: \(user.isDanger ? "Yes" : "No")")
                    Text("Is in Rescue: \(user.isInRescue ? "Rescuing" : "Yah dicuekin")")
                    Text("Last Seen at: \(user.lastSeen.latitude), \(user.lastSeen.longitude)")
                } else {
                    Text("Hiker details unavailable")
                }
            }
            .padding()
            .navigationTitle("Hiker Rescue Details")
        }
}

//#Preview {
//    RangerReceiveSOSAlertView(user: ContentView().selectedUser)
//}
