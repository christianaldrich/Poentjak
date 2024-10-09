//
//  MountainsTracksView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 08/10/24.
//

import SwiftUI

struct MountainsTracksView: View {
    @StateObject var viewModel = MountainsTracksViewModel(mountainsTracksUseCase: MountainsTracksUseCase(mountainsTracksRepository: MountainsTracksRepository()))
    
    @State var selectedMountains: MountainTracksModel?
    @State private var isDetailViewActive = false
    var body: some View {
        //        Text("Hello, World!")
        
        NavigationStack{
            List(viewModel.mountainsTracks, id: \.id){mountain in
                NavigationLink(value: mountain){
                    Text("Name: \(mountain.name)")
                }
            }
            .navigationTitle("Mountain Card")
            .navigationDestination(for: MountainTracksModel.self){mountain in
                MountainTracksDetailView(mountain: mountain)
        }
        
            
        }
        
    }
}

//#Preview {
//    MountainsTracksView()
//}
