//
//  HikersNeedHelpComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 02/10/24.
//


import SwiftUI

struct HikersNeedHelpSectionComponent: View {
    
    let hikers: [EmergencyRequestModel]
//    let users: [UserModel]
    var onRescue: (EmergencyRequestModel) -> Void
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        Section(header: Text("Need Rescue").modifier(SectionModifier())) {
            ForEach(hikers, id: \.id) { hiker in
                RangerNeedHelpComponent(hiker: hiker){
                    onRescue(hiker)
                }
                
            }
        }
        
        
    }
}
