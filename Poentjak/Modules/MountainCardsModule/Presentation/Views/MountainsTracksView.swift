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
        //        Text("Is Presenting: \(viewModel.isPresenting)")
        
        NavigationStack(path: $navigationManager.navigationPath){
            List(viewModel.mountainsTracks, id: \.id){mountain in
                //                NavigationLink(value: mountain){
                //                    Text("Name: \(mountain.name)")
                //                    navigationManager.navigationPath.append(mountain)
                Button("Name: \(mountain.name)"){
                    navigationManager.navigationPath.append(MountainDestinationView.mountainTracksDetail(mountain: mountain))
                }
                //                }
                
            }
            Button("testing"){
                //                viewModel.isPresenting = true
                //                navigationManager.popToRoot()
                viewModel.toggleIsPresenting()
            }
            .navigationTitle("Mountain Card")
            //            .navigationDestination(for: MountainTracksModel.self){mountain in
            //                MountainTracksDetailView(mountain: mountain)
            //            }
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
                EmergencyProsesView()
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

// Create a class to manage the navigation path
class MountainNavigationManager: ObservableObject {
    @Published var navigationPath = NavigationPath()
    //    @Published var selectedEmergencyType: String?
    
    
    // Method to pop to root (View A)
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count) // Clear all the navigation stack
        //        print("\n\n\nNAVPATH: \(navigationPath)")
        
    }
}
