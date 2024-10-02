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
//        VStack(alignment: .leading) {
//            Text("ID: \(user.id)")
//            Text("Name: \(user.name)")
//            Text("Age: \(user.age)")
//            Text("Gender: \(user.gender)")
//            Text("Height: \(user.height)")
//            Text("Weight: \(user.weight)")
//            Text("Last Seen at: \(user.lastSeen.latitude), \(user.lastSeen.longitude)")
//            Button("Finish Rescue"){
//                onFinishRescue()
//            }
//        }
        
        VStack(alignment: .leading, spacing: 15){
            HStack{
                Image("LoremJoe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 83, height: 55)
                    .clipShape(RoundedRectangle(cornerRadius: 11))
                VStack(alignment: .leading){
                    Text("\(user.name)")
                        .font(.headline)
                        .fontWeight(.heavy)
                    Text("Insert battery level, 3 mins ago") //Insert battery level
                        .font(.caption)
                        .fontWeight(.light)
                }
            }
            
            HStack(spacing: 20){
                VStack{
                    Text("Last Seen").modifier(AttributesInfoModifier())
                    Text("POS 2").modifier(HikersAttributeInfoModifier()) // Insert last seen WayPoint ?
                }
                VStack{
                    Text("Body Weight").modifier(AttributesInfoModifier())
                    Text("\(user.weight) kg").modifier(HikersAttributeInfoModifier())
                }
                
                VStack{
                    Text("Height").modifier(AttributesInfoModifier())
                    Text("\(user.height) cm").modifier(HikersAttributeInfoModifier())
                }
                
                VStack{
                    Text("Gender").modifier(AttributesInfoModifier())
                    Text("\(user.gender)").modifier(HikersAttributeInfoModifier())
                }
                
                VStack{
                    Text("Age").modifier(AttributesInfoModifier())
                    Text("\(user.age)").modifier(HikersAttributeInfoModifier())
                }
            }
            
            VStack(alignment: .leading){
                Text("Rangers in rescue").modifier(HikersAttributeInfoModifier())
                Text("Insert rangers assignee")
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            
            HStack(alignment:.bottom){
                HStack{
                    Image("OthersSymbol")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 17, height: 19)
                    Text("Others") //Insert Emergency Type
                        .textCase(.uppercase)
                }
                .background(.red)
                
                Spacer()
                
                Button("Rescue"){
                    onFinishRescue()
                }
                .background(.yellow)
            }
            .foregroundStyle(.white)
        }
        
        

    }
}
