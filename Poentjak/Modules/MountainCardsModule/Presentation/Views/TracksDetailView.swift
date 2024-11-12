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
    @StateObject var navigateViewModel = TracksMapViewModel(fileName: "")
    @StateObject var authViewModel: AuthViewModel
    
    @EnvironmentObject var mountainViewModel : MountainsTracksViewModel
    @State private var isShowingSelectTrackModal = true
    @State private var selectedDetent = PresentationDetent.fraction(0.5)
    
    
    var body: some View {
        VStack{

            
            TracksMapView(region: $navigateViewModel.region, waypoints: navigateViewModel.gpxParser.parsedFirstLastWaypoints, track: navigateViewModel.gpxParser.parsedTrack, showsUserLocation: true)

        }
        
        .environmentObject(navigationManager)
        .onAppear{
             navigateViewModel.fileName = track
            
            navigateViewModel.setupRegionTrack()
            viewModel.fetchEmergency()
            isShowingSelectTrackModal = true

        }
        .sheet(isPresented: $isShowingSelectTrackModal){
            SelectTrackComponent(track: track, mountainViewModel: mountainViewModel, navigationManager: navigationManager){
                isShowingSelectTrackModal = false
            }
                .presentationDetents([.fraction(0.5)], selection: $selectedDetent)
                .presentationDragIndicator(.visible)
                .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.5)))
                .interactiveDismissDisabled(true)

        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                BackButtonComponent{
                    
                }
            }
        }
        
        
        //        .navigationDestination(isPresented: $navigateToDueDate){
        //            DueDateView()
        //        }
        
        
    }
}

//#Preview {
//    TracksDetailView(track: "breeze-warung", navigationManager: MountainNavigationManager(), isShowingModal: .constant(false), navigateViewModel: UserNavigateViewModel(fileName: "pulomas"), authViewModel: AuthViewModel(useCase: DefaultAuthUseCase(authRepository: DefaultAuthRepository(), userRepository: DefaultUserRepository())))
//}
