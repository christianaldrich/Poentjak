//
//  RangerRescuingComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 01/10/24.
//

import SwiftUI

struct RangerRescuingComponent: View {
    let user: UserModel
    let onFinishRescue: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("ID: \(user.id)")
            Text("Name: \(user.name)")
            Text("Age: \(user.age)")
            Text("Gender: \(user.gender)")
            Text("Height: \(user.height)")
            Text("Weight: \(user.weight)")
            Text("Last Seen at: \(user.lastSeen.latitude), \(user.lastSeen.longitude)")
            Button("Finish Rescue"){
                onFinishRescue()
            }
        }
        .padding()
    }
}
