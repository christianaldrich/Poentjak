//
//  SelectTrackComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 06/11/24.
//

import SwiftUI

struct SelectTrackComponent: View {
    @State var track: String
    @ObservedObject var mountainViewModel : MountainsTracksViewModel
    @ObservedObject var navigationManager : MountainNavigationManager

    @State var action: () -> Void
    
    var body: some View {
        VStack{
            
            HStack(spacing: 40){
                VStack(alignment: .center, spacing: 10){
                    Text("Est. Time")
                        .font(.caption1Regular)
                    Text("7 hrs 20 min")
                        .font(.calloutEmphasized)
                }
                
                VStack(alignment: .center, spacing: 10){
                    Text("Distance (KM)")
                        .font(.caption1Regular)
                    Text("18,02")
                        .font(.calloutEmphasized)
                }
                
                VStack(alignment: .center, spacing: 10){
                    Text("Elevation")
                        .font(.caption1Regular)
                    Text("3600 m")
                        .font(.calloutEmphasized)
                }
            }
            .padding()
            
            
            Divider()
            
            Spacer().frame(height:24)
            
            ForEach(mountainViewModel.selectedTracks, id: \.self){
                result in
                if result.id == track{
                    Text("\(result.desc)")
                        .font(.calloutRegular)
                        .foregroundStyle(Color.primaryGreen500)

                }
            }
            
            Spacer()
            
            CustomLargeButtonComponent(state: .enabled, text: "Start Tracking"){
                action()
                navigationManager.navigationPath.append(MountainDestinationView.dueDate(trackLocation: track))
            }
        }
        .padding()
        
    }
}

//#Preview {
//    SelectTrackComponent(track: "", mountainViewModel: MountainsTracksViewModel)
//}
