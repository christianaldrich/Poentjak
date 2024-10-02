//
//  RangerRescuingSectionComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 02/10/24.
//

import SwiftUI

struct RangerRescuingSectionComponent: View {
    
    let users: [UserModel]
    var onRescue: (UserModel) -> Void
    
    var body: some View {
        Section(header: Text("Ongoing Rescues").modifier(SectionModifier())) {
            ForEach(users, id: \.id) { user in
                RangerRescuingComponent(user: user){
                    onRescue(user)
                }
            }
        }
    }
}
