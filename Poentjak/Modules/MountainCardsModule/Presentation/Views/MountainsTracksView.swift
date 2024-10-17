//
//  MountainsTracksView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 08/10/24.
//

import SwiftUI

enum MountainDestinationView: Hashable{
    case mountainTracksDetail(mountain: MountainTracksModel?)
    case tracksDetail(tracks: String)
    case dueDate(trackLocation: String)
}

struct MountainsTracksView: View {
    @StateObject var viewModel = MountainsTracksViewModel(mountainsTracksUseCase: MountainsTracksUseCase(mountainsTracksRepository: MountainsTracksRepository()))
    
    @StateObject var authViewModel: AuthViewModel
    @StateObject var navigationManager = MountainNavigationManager()
    
    
    
    var body: some View {
        
        NavigationStack(path: $navigationManager.navigationPath){
            List(viewModel.mountainsTracks, id: \.id){mountain in
                Button("Name: \(mountain.name)"){
                    navigationManager.navigationPath.append(MountainDestinationView.mountainTracksDetail(mountain: mountain))
                }
                
                
            }
            
            .navigationTitle("Mountain Card")
            .navigationDestination(for: MountainDestinationView.self){ destination in
                switch destination{
                case .mountainTracksDetail(let mountain):
                    MountainTracksDetailView(mountain: mountain, navigationManager: navigationManager)
                        .environmentObject(viewModel)
                        .environmentObject(navigationManager)
                    
                case .tracksDetail(let track):
                    TracksDetailView(track: track, navigationManager: navigationManager)
                        .environmentObject(viewModel)
                        .environmentObject(navigationManager)
                    
                case .dueDate(let trackLocation):
                    DueDateView(trackLocation: trackLocation)
                        .environmentObject(viewModel)
                        .environmentObject(navigationManager)
                }
                
            }
            .fullScreenCover(isPresented: $viewModel.isPresenting){
                EmergencyProsesView(navigateViewModel: UserNavigateViewModel(fileName: viewModel.selectedTrackLocation))
                    .environmentObject(viewModel)
                
            }
            
        }
        .environmentObject(navigationManager)
        
        Button(action: {
            Task {
                await authViewModel.signOut()
            }
        }) {
            Text("Sign Out")
                .font(.headline)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
        
        
    }
    
}

//#Preview {
//    MountainsTracksView()
//}


class MountainNavigationManager: ObservableObject {
    @Published var navigationPath = NavigationPath()

    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}
