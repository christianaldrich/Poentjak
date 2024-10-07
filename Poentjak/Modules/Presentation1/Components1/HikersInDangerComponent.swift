//
//  HikersInDangerComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 01/10/24.
//

import SwiftUI

struct HikersInDangerComponent: View {
    @StateObject private var viewModel = UserViewModel()
    @State private var activeEmergencies = [UserModel]()
    
    @State var selectedUser: UserModel?
    @State private var isDetailViewActive = false
    
    var body: some View {
        
                Text("asdf")
                ForEach(viewModel.user, id: \.id) { user in
                    VStack(alignment: .leading) {
                        Text("asdf")
                        Text("ID: \(user.id)")
                        Text("Name: \(user.name)")
                        Text("Age: \(user.age)")
                        Text("Gender: \(user.gender)")
                        Text("Height: \(user.height)")
                        Text("Weight: \(user.weight)")
                        Text("Is in Danger: \(user.isDanger ? "Yes" : "No")")
                        Text("Is in Rescue: \(user.isInRescue ? "Rescuing" : "Yah dicuekin")")
                        Text("Last Seen at: \(user.lastSeen.latitude), \(user.lastSeen.longitude)")
                        
                        Button("Confirm Rescue") {
                            viewModel.rescuing(id: user.id)
    //                        selectedUser = user
    //                        isDetailViewActive = true
                        }
                    }
                    .padding()
                }
            
        
    }
}

#Preview {
    HikersInDangerComponent()
}
