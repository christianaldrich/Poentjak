//
//  SearchMountainCardComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 01/11/24.
//

import SwiftUI

struct SearchMountainCardComponent: View {
    
//    @StateObject var viewModel : MountainsTracksViewModel
    @State var mountain: String
    @State var streetName: String
    
    var body: some View {
        HStack{
            Image.LabelIcon.clockBig
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 28, height: 28)
            
            VStack(alignment: .leading){
                Text("\(mountain)")
                    .font(.subheadlineRegular)
                    .foregroundStyle(Color.primaryGreen500)
                Text("\(streetName)")
                    .font(.footnoteRegular)
                    .foregroundStyle(Color.neutralGrayTertiaryGray)
            }
            
        }
        .padding()
    }
}

#Preview {
    SearchMountainCardComponent(mountain: "Gunung Ciremai", streetName: "testing")
}
