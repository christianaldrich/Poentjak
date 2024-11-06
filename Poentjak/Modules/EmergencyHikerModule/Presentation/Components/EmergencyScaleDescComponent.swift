//
//  EmergencyScaleDescComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 06/11/24.
//

import SwiftUI

struct EmergencyScaleDescComponent: View {
    
    @State var emergencyTypeDesc: EmergencyType
    
    var body: some View {
        switch emergencyTypeDesc{
        case .lost:
            VStack(alignment: .leading,spacing:16){
                HStack{
                    Image.LabelIcon.number1
                    Text("**Mildly Disoriented:** Unsure of location, but\nknow the general direction.")
                }
                
                HStack{
                    Image.LabelIcon.number2
                    Text("**Uncertain:** Lost the trail but have a map or\nGPS to guide.")
                }
                
                HStack{
                    Image.LabelIcon.number3
                    Text("**Lost:** Can’t find the trail, unsure where to\ngo.")
                }
                
                HStack{
                    Image.LabelIcon.number4
                    Text("**Very Lost:** No idea of current location,\nunsure of surroundings.")
                }
                
                HStack{
                    Image.LabelIcon.number5
                    Text("**Critical:** Completely lost, no signal, potential danger (We will alert nearby rangers).")
                }
                
            }
            .font(.subheadlineRegular)
            .padding()
        case .hipo:
            VStack(alignment: .leading,spacing:20){
                HStack{
                    Image.LabelIcon.number1
                    Text("**Mild:** Light shivers, feeling cold.")
                }
                
                HStack{
                    Image.LabelIcon.number2
                    Text("**Moderate:** Shivering more, hands getting\nnumb.")
                }
                
                HStack{
                    Image.LabelIcon.number3
                    Text("**Worsening:** Strong shivers, trouble moving\nfingers, feeling tired.")
                }
                
                HStack{
                    Image.LabelIcon.number4
                    Text("**Severe:** Uncontrollable shivering, slow\nmovements, confusion/illusions.")
                }
                
                HStack{
                    Image.LabelIcon.number5
                    Text("**Critical:** Hot, extreme fatigue, trouble\nbreathing, can’t move (We will alert nearby\nrangers).")
                }
                
            }
            .font(.subheadlineRegular)
            .padding()
        default:
            VStack(alignment: .leading,spacing:20){
                HStack{
                    Image.LabelIcon.number1
                    Text("**Minor:** Small cut or bruise, no pain.")
                }
                
                HStack{
                    Image.LabelIcon.number2
                    Text("**Mild:** Sore muscles or minor sprain, but still\nable to move.")
                }
                
                HStack{
                    Image.LabelIcon.number3
                    Text("**Moderate:** Sharp pain, limited movement,\nswelling.")
                }
                
                HStack{
                    Image.LabelIcon.number4
                    Text("**Severe:** Intense pain, difficulty moving,\npossible fracture.")
                }
                
                HStack{
                    Image.LabelIcon.number5
                    Text("**Critical:** Unable to move, severe injury (We\nwill alert nearby rangers).")
                }
                
            }
            .font(.subheadlineRegular)
            .padding()
        }
            
                
    }
}

#Preview {
    EmergencyScaleDescComponent(emergencyTypeDesc: .hipo)
}
