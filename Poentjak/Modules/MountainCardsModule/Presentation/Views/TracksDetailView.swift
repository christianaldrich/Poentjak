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
    @State private var isShowingPopUp = true
    
    
    var body: some View {
        ZStack{
            VStack{
                
                
                TracksMapView(region: $navigateViewModel.region, waypoints: navigateViewModel.gpxParser.parsedFirstLastWaypoints, track: navigateViewModel.gpxParser.parsedTrack, showsUserLocation: true)
                    .edgesIgnoringSafeArea(.all)
                
            }
            
            .environmentObject(navigationManager)
            .onAppear{
                navigateViewModel.fileName = track
                
                // navigateViewModel.setupRegionTrack()
                navigateViewModel.setupRegionTrackSouth()
                viewModel.fetchEmergency()
                isShowingSelectTrackModal = false
                isShowingPopUp = true
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
                        isShowingSelectTrackModal = false
                    }
                    .disabled(isShowingPopUp)
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            

        }
        // Popup and darkened background
        .overlay {
            if isShowingPopUp {
                ZStack {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all) // Ensures the dark background spans the entire screen
                    
                    CustomPopUpComponent(
                        title: "Reminder",
                        subtitle: "Bring a powerbank!",
                        message: "Keep your phone charged for safety, navigation, and alerts.",
                        imgName: "Disclaimer_Cropped"
                    ) {
                        isShowingPopUp = false
                        isShowingSelectTrackModal = true
                    }
                    .zIndex(2)
                }
            }
        }

        
    }
}

//#Preview {
//    TracksDetailView(track: "breeze-warung", navigationManager: MountainNavigationManager(), isShowingModal: .constant(false), navigateViewModel: UserNavigateViewModel(fileName: "pulomas"), authViewModel: AuthViewModel(useCase: DefaultAuthUseCase(authRepository: DefaultAuthRepository(), userRepository: DefaultUserRepository())))
//}
