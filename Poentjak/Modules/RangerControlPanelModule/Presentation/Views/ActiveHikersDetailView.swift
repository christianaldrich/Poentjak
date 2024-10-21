//
//  ActiveHikersDetailView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 07/10/24.
//

import SwiftUI

struct ActiveHikersDetailView: View {
    let hiker: EmergencyRequestModel?
    
    var body: some View {
        VStack{
            Image("profPic")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 86,height: 83)
                .clipShape(RoundedRectangle(cornerRadius: 17))
            Text("Name: \(hiker?.user?.name ?? "")")
            Text("Weight: \(hiker?.user?.weight ?? 0)")
            Text("Age: \(hiker?.user?.age ?? 0)")
            Text("Height: \(hiker?.user?.height ?? 0)")
//            Text("\(hiker.user.)")
            Button("Back at basecamp"){
                //Insert actions
            }
        }
    }
}

//#Preview {
//    ActiveHikersDetailView()
//}
