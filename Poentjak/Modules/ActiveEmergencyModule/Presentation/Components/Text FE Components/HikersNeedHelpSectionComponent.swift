//
//  HikersNeedHelpComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 02/10/24.
//


import SwiftUI

struct HikersNeedHelpSectionComponent: View {
    
    let hikers: [EmergencyRequestModel]
    @StateObject var authViewModel: AuthViewModel
    var onRescue: (EmergencyRequestModel) -> Void
    
    
    var body: some View {
//        Section(header: Text("Need Rescue").modifier(SectionModifier())) {
            ForEach(hikers
                    , id: \.id) { hiker in
                HikersNeedHelpComponent(hiker: hiker, authViewModel: authViewModel){
                    onRescue(hiker)
                }
                
            }
//        }
        
        
    }
}


//    .filter{ hiker in
//        hiker.emergencyStatus == "danger"
//    }
