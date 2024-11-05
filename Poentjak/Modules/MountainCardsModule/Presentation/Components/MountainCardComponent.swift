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
            Image("gunungGede")
                .resizable()
                .aspectRatio(contentMode: .fit)
//                .frame(width: 878, height: 154)
            
            HStack{
                Image.ExploreIcon.mountainBig
                
                Text("\(mountain?.name ?? "")")
                    .font(.title2Emphasized)
            }
            
            Text("\(mountain?.description ?? "")")
                .font(.calloutRegular)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        
    }
}

//#Preview {
//    MountainCardComponent(mountain: MountainTracksModel(dictionary: [String : Any]))
//}
