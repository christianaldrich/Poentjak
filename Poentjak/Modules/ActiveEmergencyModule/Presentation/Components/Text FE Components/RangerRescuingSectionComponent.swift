//
//  RangerRescuingSectionComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 02/10/24.
//

import SwiftUI

struct RangerRescuingSectionComponent: View {
    
    let hikers: [EmergencyRequestModel]
    var onRescue: (EmergencyRequestModel) -> Void
    
    var body: some View {
//        Section(header: Text("Ongoing Rescues").modifier(SectionModifier())) {
            ForEach(hikers.filter{ hiker in
                hiker.emergencyStatus == "ongoing"
            
            }, id: \.id) { hiker in
                RangerRescuingComponent(hiker: hiker){
                    onRescue(hiker)
                }
            }
//        }
    }
}