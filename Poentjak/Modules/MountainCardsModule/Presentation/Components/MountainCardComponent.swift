//
//  MountainCardComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 03/11/24.
//

import SwiftUI

struct MountainCardComponent: View {
    let mountain: MountainTracksModel?

    var body: some View {
        VStack{
            Image("dummy")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 338, height: 184)
            
            HStack{
                Image.ExploreIcon.mountainBig
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35)
                Text("\(mountain?.name ?? "")")
                    .font(.title2Emphasized)
            }
            
            Text("\(mountain?.description ?? "")")
                .font(.calloutRegular)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                BackButtonComponent{
                    print("asdf")
                }
            }
        }
        
    }
}

//#Preview {
//    MountainCardComponent(mountain: MountainTracksModel(dictionary: <#[String : Any]#>))
//}
