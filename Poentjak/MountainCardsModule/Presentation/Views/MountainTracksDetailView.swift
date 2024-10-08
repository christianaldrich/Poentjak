//
//  MountainTracksDetailView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 08/10/24.
//

import SwiftUI

struct MountainTracksDetailView: View {
    let mountain: MountainTracksModel?
    
    var body: some View {
//        NavigationStack{
            VStack{
                if let mountain = mountain{
                    Text("Name: \(mountain.name)")
                    Text("Desc: \(mountain.description)")
                    Text("Height: \(mountain.height)")
                    Text("Tracks: ")
                    ForEach(mountain.tracks, id: \.self){ track in
                        NavigationLink(value: track){
                            Text("\(track)")
                        }
                    }
                    
    //                List(mountain.tracks, id: \.self){track in
    //
    //                }
                    
                    Text("Location: \(mountain.location))")
                    
                    
                }
            }
            .navigationDestination(for: String.self){track in
                TracksDetailView(track: track)
            }
            .navigationTitle("Mountain Details")
//        }
    }
}

//#Preview {
//    MountainTracksDetailView()
//}
