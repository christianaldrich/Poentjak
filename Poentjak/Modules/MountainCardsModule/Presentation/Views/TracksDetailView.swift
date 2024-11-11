//
//  TracksDetailView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 08/10/24.
//

import SwiftUI

struct TracksDetailView: View {
    @State var track: String
    @State private var navigateToDueDate = false
    @ObservedObject var navigationManager : MountainNavigationManager
    @Binding var isShowingModal: Bool
    
    @StateObject var viewModel : EmergencyProsesViewModel
    @StateObject var navigateViewModel = UserNavigateViewModel(fileName: "")
    @StateObject var authViewModel: AuthViewModel
    
    @EnvironmentObject var mountainViewModel : MountainsTracksViewModel
    @State private var isShowingSelectTrackModal = true

    
//    @ObservedObject var viewModel: MountainsTracksViewModel

    
    
    var body: some View {
        VStack{
            //            Text("Name: \(track)")
            
            MapView(region: $navigateViewModel.region, waypoints: navigateViewModel.gpxParser.parsedWaypoints, track: navigateViewModel.gpxParser.parsedTrack, showsUserLocation: true, dots: navigateViewModel.dots, fileName: track)
            
            
            
            
            
            
            //            NavigationLink{
            //                DueDateView(trackLocation: track)
            //            }label: {
            //                Text("Start Tracking")
            //            }
            //
        }
        .environmentObject(navigationManager)
        .onAppear{
            navigateViewModel.fileName = track
            
            navigateViewModel.setupRegionUser()
            viewModel.fetchEmergency()
            isShowingSelectTrackModal = true
            //            navigateViewModel.fileName = viewModel.trackId
            //            print("VM Track ID : \(viewModel.trackId)")
            //            print("\n\nTRACK: \(track)")
            //
            //
            //            print("\n\nFILENAME: \(navigateViewModel.fileName)")
            //            print("\n\nviewModel.trackID: \(viewModel.trackId)")
            //            navigateViewModel.updateTrackId(track)
        }
        .sheet(isPresented: $isShowingSelectTrackModal){
            SelectTrackComponent(track: track, mountainViewModel: mountainViewModel, navigationManager: navigationManager){
                isShowingSelectTrackModal = false
            }
                .presentationDetents([.fraction(0.5), .large])

        }
        
        
        //        .navigationDestination(isPresented: $navigateToDueDate){
        //            DueDateView()
        //        }
        
        
    }
}

//#Preview {
//    TracksDetailView(track: "breeze-warung", navigationManager: MountainNavigationManager(), isShowingModal: .constant(false), navigateViewModel: UserNavigateViewModel(fileName: "pulomas"), authViewModel: AuthViewModel(useCase: DefaultAuthUseCase(authRepository: DefaultAuthRepository(), userRepository: DefaultUserRepository())))
//}
