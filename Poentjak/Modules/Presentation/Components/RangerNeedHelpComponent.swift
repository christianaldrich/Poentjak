//
//  RangerListText.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 01/10/24.
//

import SwiftUI

struct RangerNeedHelpComponent: View {
    
    let hiker: EmergencyRequestModel
    let user: [UserModel]
    var onConfirmRescue: () -> Void
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text("Assigned Rangers: \(hiker.assignedRangers[0]), \(hiker.assignedRangers[1])")
            Text("Hiker's due date: \(hiker.dueDate.formatted(date: .complete, time: .shortened))")
            Text("Emergency type: \(hiker.emergencyType)")
            Text("FullName: \(user)")
        }
        
        
        
        
    }
}


//        VStack(alignment: .leading, spacing: 15){
//            HStack{
//                Image("LoremJoe")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 83, height: 55)
//                    .clipShape(RoundedRectangle(cornerRadius: 11))
//                VStack(alignment: .leading){
//                    Text("\(hiker.name)")
//                        .font(.headline)
//                        .fontWeight(.heavy)
//                    Text("Insert battery level, 3 mins ago") //Insert battery level
//                        .font(.caption)
//                        .fontWeight(.light)
//                }
//            }
//
//            HStack(spacing: 20){
//                VStack{
//                    Text("Last Seen").modifier(AttributesInfoModifier())
//                    Text("POS 2").modifier(HikersAttributeInfoModifier()) // Insert last seen WayPoint ?
//                }
//                VStack{
//                    Text("Body Weight").modifier(AttributesInfoModifier())
//                    Text("\(hiker.weight) kg").modifier(HikersAttributeInfoModifier())
//                }
//
//                VStack{
//                    Text("Height").modifier(AttributesInfoModifier())
//                    Text("\(hiker.height) cm").modifier(HikersAttributeInfoModifier())
//                }
//
//                VStack{
//                    Text("Gender").modifier(AttributesInfoModifier())
//                    Text("\(hiker.gender)").modifier(HikersAttributeInfoModifier())
//                }
//
//                VStack{
//                    Text("Age").modifier(AttributesInfoModifier())
//                    Text("\(hiker.age)").modifier(HikersAttributeInfoModifier())
//                }
//            }
//
//            HStack(alignment:.bottom){
//                HStack{
//                    Image("HypoSymbol")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 17, height: 19)
//                    Text("Hypothermia") //Insert Emergency Type
//                        .textCase(.uppercase)
//
//                }
//                .background(.blue)
//
//                Spacer()
//
//                Button("Rescue"){
//                    onConfirmRescue()
//                }
//                .background(.red)
//            }
//            .foregroundStyle(.white)
//        }
