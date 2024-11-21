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
        VStack(spacing:8){
            Image("gunungGede")
                .resizable()
                .frame(width: 338, height: 139)
                .scaledToFit()
                
            
            VStack(spacing:8){
                HStack{
                    Image.ExploreIcon.mountainBig
                    
                    Text("\(mountain?.name ?? "")")
                        .font(.title2Emphasized)
                }
                
                HStack(spacing: 40){
                    VStack(alignment: .center, spacing: 10){
                        Text("Est. Time")
                            .font(.caption1Regular)
                        Text("7 hrs 20 min")
                            .font(.calloutEmphasized)
                    }
                    
                    VStack(alignment: .center, spacing: 10){
                        Text("Distance")
                            .font(.caption1Regular)
                        Text("18,02km")
                            .font(.calloutEmphasized)
                    }
                    
                    VStack(alignment: .center, spacing: 10){
                        Text("Elevation")
                            .font(.caption1Regular)
                        Text("3600m")
                            .font(.calloutEmphasized)
                    }
                }
            }
            
            
            Divider()
            
            Text("\(mountain?.description ?? "")")
                .font(.calloutRegular)
                .foregroundStyle(Color.primaryGreen500)
                .padding(.top,16)
            Spacer()
        }
        .padding(.leading,27)
        .padding(.trailing,27)
        .navigationBarBackButtonHidden(true)
        
    }
}

//#Preview {
//    MountainCardComponent(mountain: MountainTracksModel(dictionary: [String : Any]))
//}
