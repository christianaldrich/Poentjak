//
//  EmergencyProsesView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 29/09/24.
//

import SwiftUI
import CoreLocation

enum DestinationView {
    case editDueDate
    case chooseEmergency
    case alertGuide
    case countDown
    case soundBoard
}

struct EmergencyProsesView: View {
    @StateObject var viewModel = EmergencyProsesViewModel()
    @StateObject var navigateViewModel = UserNavigateViewModel(fileName: "")
    
    
    @EnvironmentObject var mountainViewModel : MountainsTracksViewModel
    
    @State var trackLocation: String?
    
    
    @State private var showSOSView = false
    
    @State private var navigateToDueDate = false
    
    @StateObject private var navigationManager = NavigationManager()
    
    @State private var isShowingModal = true
    @State private var showConfirmationModal = false
    @State private var selectedDetent = PresentationDetent.fraction(0.4)
    
    
    var body: some View {
        NavigationStack(path: $navigationManager.navigationPath) {
            
            VStack {
                
                GeometryReader { geometry in
                    MapView(region: $navigateViewModel.region, waypoints: navigateViewModel.gpxParser.parsedWaypoints, track: navigateViewModel.gpxParser.parsedTrack, showsUserLocation: true, dots: navigateViewModel.dots, fileName: viewModel.trackId)
                        .frame(height: geometry.size.height * 1.1)
                        .edgesIgnoringSafeArea(.all)
                    
                    
                    VStack {
                        VStack {
                            TopETAView(navigateViewModel: navigateViewModel, viewModel: viewModel, isShowingModal: $isShowingModal)
                        }
                        
                        
                        SOSButtonView(navigationPath: $navigationManager.navigationPath)
                            .offset(x: viewModel.showSOSButtonView ? 0 : -UIScreen.main.bounds.width)
                            .animation(viewModel.deleteAnimation ? nil : .easeInOut(duration: 0.5), value: viewModel.showSOSButtonView)
                            .zIndex(2)
                        
                    }
                    .sheet(isPresented: $isShowingModal) {
                        ScrollView{
                            VStack{
                                
                                HStack{
                                    HalfButtonComponent(halfType: .secondaryGuide) {
                                        isShowingModal = false
                                        navigationManager.navigationPath.append(DestinationView.alertGuide)
                                    }
                                    Spacer()
                                    
                                    if viewModel.isSignalSent && viewModel.sendSOSToFirebase{
                                        HalfButtonComponent(halfType: .SOSSent) {
                                            isShowingModal = false
                                            withAnimation {
                                                viewModel.showSOSButtonView.toggle()
                                            }
                                        }
                                    } else if viewModel.isSignalSent && !viewModel.sendSOSToFirebase{
                                        HalfButtonComponent(halfType: .SOSSending) {
                                            isShowingModal = false
                                            withAnimation {
                                                viewModel.showSOSButtonView.toggle()
                                            }
                                        }
                                    } else {
                                        HalfButtonComponent(halfType: .SOS) {
                                            isShowingModal = false
                                            withAnimation {
                                                viewModel.showSOSButtonView.toggle()
                                            }
                                        }
                                    }
                                    
                                }
                                .padding(.horizontal, 24)
                                .padding(.top, 32)
                                .padding(.bottom, 16)
                                
                                ReturnDateButton(time: viewModel.dueDate) {
                                    isShowingModal = false
                                    navigationManager.navigationPath.append(DestinationView.editDueDate)
                                }
                                .padding(.horizontal, 24)
                                
                                VStack(alignment: .center) {
                                    Text("Important:")
                                        .foregroundColor(.errorRed500)
                                        .font(.subheadlineEmphasized) +
                                    Text(" Make sure to finish the trip \nwhen arriving at the basecamp.")
                                        .foregroundColor(.primaryGreen500) // Default color for the rest of the text
                                        .font(.subheadlineRegular)
                                }
                                .multilineTextAlignment(.center)
                                .padding(.top, 16)
                                
                                //                                SlideToActionButton(slidingDirection: .ltr, buttonColor: .primaryGreen500, text: "Finish trip") {
                                //                                    Task{
                                //                                        await viewModel.updateSessionDone()
                                //                                        navigateViewModel.isNavigating = false
                                //                                        navigateViewModel.stopTimer()
                                //                                        SOSManager.shared.isSOS = false
                                //                                        navigateViewModel.isSOS = false
                                //
                                //                                        mountainViewModel.toggleIsPresenting()
                                //                                        mountainViewModel.toggleIsPresenting()
                                //
                                //
                                //                                    }
                                //                                }
                                //                                .padding(.horizontal, 24)
                                //                                .padding(.top, 16)
                                
                                SlideToActionButton(slidingDirection: .ltr, buttonColor: .primaryGreen500, text: "Finish trip") {
                                    if viewModel.isSignalSent {
                                        // Show the confirmation modal when isSignalSent is true
                                        showConfirmationModal = true
                                        isShowingModal = false
                                    } else {
                                        // Run the task as before if isSignalSent is not true
                                        Task {
                                            await viewModel.updateSessionDone()
                                            navigateViewModel.isNavigating = false
                                            navigateViewModel.stopTimer()
                                            SOSManager.shared.isSOS = false
                                            navigateViewModel.isSOS = false
                                            
                                            mountainViewModel.toggleIsPresenting()
                                            mountainViewModel.toggleIsPresenting()
                                        }
                                    }
                                }
                                .padding(.horizontal, 24)
                                .padding(.top, 16)
                                
                            }
                        }
                        .presentationDetents([.fraction(0.4), .fraction(0.1)], selection: $selectedDetent)
                        .presentationDragIndicator(.visible)
                        .presentationBackgroundInteraction(
                            .enabled(upThrough: .fraction(0.4))
                        )
                        .interactiveDismissDisabled(true)
                    }
                    
                    
                    
                }
                .navigationDestination(for: DestinationView.self) { destination in
                    switch destination {
                    case .editDueDate:
                        EditDueDateView(viewModel: viewModel)
                            .environmentObject(navigationManager)
                    case .chooseEmergency:
                        ChooseEmergencyTypeView(viewModel: viewModel)
                            .environmentObject(navigationManager)
                    case .alertGuide:
                        AlertGuideView(viewModel: viewModel)
                            .environmentObject(navigationManager)
                    case .countDown:
                        CountDownView(viewModel: viewModel)
                            .environmentObject(navigationManager)
                    case .soundBoard:
                        SoundBoardView()
                            .environmentObject(navigationManager)
                    }
                }
                .onAppear{
                    viewModel.deleteAnimation = false
                    navigateViewModel.setupRegionUser()
                    isShowingModal = true
                }
                .onChange(of: viewModel.sessionId){
                    if viewModel.sessionId == "no session id"{
                        mountainViewModel.toggleIsPresenting()
                    }
                }
                
            }
            .overlay {
                // Show the modal overlay with darkened background when the modal is shown
                if showConfirmationModal {
                    ZStack{
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                        
                        CustomConfirmationComponent(confirmType: .evacuated, isModalVisible: $showConfirmationModal, sosGuideModalVisible: $isShowingModal){
                            // Run the task when the confirmation button is tapped
                            Task {
                                await viewModel.updateSessionDone()
                                navigateViewModel.isNavigating = false
                                navigateViewModel.stopTimer()
                                SOSManager.shared.isSOS = false
                                navigateViewModel.isSOS = false
    
                                mountainViewModel.toggleIsPresenting()
                                mountainViewModel.toggleIsPresenting()
                            }
                            // Dismiss the modal
                            showConfirmationModal = false
                        }
                        
                    }

                }
            }
            .environmentObject(navigationManager)
            
            .onAppear{
                viewModel.fetchEmergency()
                navigateViewModel.fileName = viewModel.trackId
                //            navigateViewModel.updateTrackId(viewModel.trackId)
                //            navigateViewModel.setupRegionUser()
                viewModel.startTimer()
                navigateViewModel.isNavigating = true
                navigateViewModel.startTimer()
                isShowingModal = true
            }
            .onChange(of: navigationManager.navigationPath) { newPath in
                // Check if we're navigating back to this view
                if newPath.isEmpty { // Adjust this logic based on your navigation structure
                    isShowingModal = true // Show modal when going back to the view
                }
            }
        }
    }
}

#Preview {
    EmergencyProsesView()
}


struct DummyMapView: View {
    var body: some View {
        // Placeholder for map view
        Rectangle()
            .fill(Color.gray)
            .overlay(
                Image(systemName: "house")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            )
    }
}



// Create a class to manage the navigation path
class NavigationManager: ObservableObject {
    @Published var navigationPath = NavigationPath()
    //    @Published var selectedEmergencyType: String?
    
    
    // Method to pop to root (View A)
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count) // Clear all the navigation stack
        //        print("\n\n\nNAVPATH: \(navigationPath)")
        
    }
}
