//
//  HikersNeedHelpComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 02/10/24.
//


import SwiftUI

struct HikersNeedHelpSectionComponent: View {
    
    let users: [UserModel]
    var onRescue: (UserModel) -> Void
    
    var body: some View {
        Section(header: Text("Need Rescue").modifier(SectionModifier())) {
            ForEach(users, id: \.id) { user in
                RangerNeedHelpComponent(user: user){
                    onRescue(user)
                }
            }
        }
    }
}
