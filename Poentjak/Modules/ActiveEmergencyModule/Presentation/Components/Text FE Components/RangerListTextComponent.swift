//
//  RangerListText.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 01/10/24.
//

import SwiftUI

struct RangerNeedHelpComponent: View {
    
    let user: UserModel
    var onConfirmRescue: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("ID: \(user.id)")
            Text("Name: \(user.name)")
            Text("Age: \(user.age)")
            Text("Gender: \(user.gender)")
            Text("Height: \(user.height)")
            Text("Weight: \(user.weight)")
//            Text("Is in Danger: \(user.isDanger ? "Yes" : "No")")
//            Text("Is in Rescue: \(user.isInRescue ? "Rescuing" : "Yah dicuekin")")
//            Text("Last Seen at: \(user.lastSeen.latitude), \(user.lastSeen.longitude)")
            
//            Button("Confirm Rescue") {
//                onConfirmRescue()
//            }
        }
        .padding()
    }
}
