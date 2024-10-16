//
//  MountainTracksDetailView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 08/10/24.
//

import SwiftUI

struct MountainTracksDetailView: View {
    let mountain: MountainTracksModel?
    @ObservedObject var navigationManager : MountainNavigationManager

    
    var body: some View {
            VStack{
                
                if let mountain = mountain{
                    Text("Name: \(mountain.name)")
                    Text("Desc: \(mountain.description)")
                    Text("Height: \(mountain.height)")
                    Text("Tracks: ")
                    ForEach(mountain.tracks, id: \.self){ track in
//                        NavigationLink(value: track){
//                            Text("\(track)")
//                        }
                        Button("\(track)"){
                            navigationManager.navigationPath.append(MountainDestinationView.tracksDetail(tracks: track))
                        }
                    }
                    
    //                List(mountain.tracks, id: \.self){track in
    //
    //                }
                    
                    Text("Location: \(mountain.location))")
                    
                    
                }
            }
//            .navigationDestination(for: String.self){track in
//                TracksDetailView(track: track)
//            }
//            .navigationDestination(for: MountainDestinationView.self){ destination in
//                switch destination{
//                case .mountainTracksDetail(let mountain):
//                    MountainTracksDetailView(mountain: mountain, navigationManager: navigationManager)
//                case .tracksDetail(let track):
//                    TracksDetailView(track: track)
//                }
//                
//            }
            .navigationTitle("Mountain Details")

    }
}

//#Preview {
//    MountainTracksDetailView()
//}
