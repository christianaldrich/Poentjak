//
//  RangerListText.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 01/10/24.
//

import SwiftUI

struct HikersNeedHelpComponent: View {
    
    let hiker: EmergencyRequestModel
//    let user: [UserModel]
    var onConfirmRescue: () -> Void
    
    var body: some View {
        
        VStack(alignment: .leading){

//            Text("Name: \(hiker.user?.name ?? "")")
//            Text("Weight: \(hiker.user?.weight ?? 0)")
//            Text("Height: \(hiker.user?.height ?? 0)")
//            Text("Emergency Type: \(hiker.emergencyType)")
//            Text("Emergency Status: \(hiker.emergencyStatus)")
//            Text("TrackId: \(hiker.user?.trackId ?? "DEF")")
            Button(action: onConfirmRescue){
                EmergencyCardComponent(name: hiker.user?.name ?? "",
                                       gender: hiker.user?.gender ?? "",
                                       type: hiker.emergencyType,
                                       age: hiker.user?.age ?? 0,
                                       weight: hiker.user?.weight ?? 0,
                                       height: hiker.user?.height ?? 0,
                                       status: hiker.emergencyStatus)
            }
            .buttonStyle(PlainButtonStyle())

//            Text("FullName: \(hiker.user?.contactName ?? "")")
//            Button("Rescue"){
//                onConfirmRescue()
//            }
//            .background(.red)
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
