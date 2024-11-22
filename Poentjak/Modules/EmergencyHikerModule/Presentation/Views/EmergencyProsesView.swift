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
    case emergencyScale
    case countDown
    case soundBoard
    case wiseGuide
}

struct EmergencyProsesView: View {
    @StateObject var viewModel = EmergencyProsesViewModel()
    @StateObject var navigateViewModel = UserNavigateViewModel(fileName: "")
    @EnvironmentObject var mountainViewModel: MountainsTracksViewModel
    @State var trackLocation: String?
    @StateObject private var navigationManager = NavigationManager()
    @State private var isShowingModal = false
    @State private var showConfirmationModal = false
    @State private var selectedDetent = PresentationDetent.fraction(0.4)
    @State private var showingWiseGudieSheet = false
    
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
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .sheet(isPresented: $isShowingModal) {
                        ScrollView {
                            VStack {
                                HStack {
                                    HalfButtonComponent(halfType: .secondaryGuide) {
                                        showingWiseGudieSheet = true
                                        isShowingModal = false
                                        navigationManager.navigationPath.append(DestinationView.wiseGuide)
                                    }
                    
                                    Spacer()
                                    
                                    if viewModel.isSignalSent && viewModel.sendSOSToFirebase {
                                        HalfButtonComponent(halfType: .SOSSent) {
                                            isShowingModal = false
                                            navigationManager.navigationPath.append(DestinationView.chooseEmergency)
                                        }
                                    } else if viewModel.isSignalSent && !viewModel.sendSOSToFirebase {
                                        HalfButtonComponent(halfType: .SOSSending) {
                                            isShowingModal = false
                                            navigationManager.navigationPath.append(DestinationView.chooseEmergency)
                                        }
                                    } else {
                                        HalfButtonComponent(halfType: .SOS) {
                                            isShowingModal = false
                                            navigationManager.navigationPath.append(DestinationView.chooseEmergency)
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
                                        .foregroundColor(.primaryGreen500)
                                        .font(.subheadlineRegular)
                                }
                                .multilineTextAlignment(.center)
                                .padding(.top, 16)
                                

                                SlideToActionButton(slidingDirection: .ltr, buttonColor: .primaryGreen500, text: "Finish trip") {
                                    if viewModel.isSignalSent {
                                        
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
                                            
//                                            mountainViewModel.toggleIsPresenting()
//                                            mountainViewModel.toggleIsPresenting()
                                            mountainViewModel.isPresenting = false
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                isShowingModal = false
                                            }
                                    }
                                }
                                .padding(.horizontal, 24)
                                .padding(.top, 16)
                            }
                        }
                        .presentationDetents([.fraction(0.4), .fraction(0.1)], selection: $selectedDetent)
                        .presentationDragIndicator(.visible)
                        .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.4)))
                        .interactiveDismissDisabled(true)
                    }
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
                case .emergencyScale:
                    EmergencyScaleView(viewModel: viewModel)
                        .environmentObject(navigationManager)
                case .countDown:
                    CountDownView(viewModel: viewModel)
                        .environmentObject(navigationManager)
                case .soundBoard:
                    SoundBoardView()
                        .environmentObject(navigationManager)
                case .wiseGuide:
                    WiseGuideViewEmergency(viewModel: viewModel)
                        .environmentObject(navigationManager)
                }
            }
            .overlay {
                if showConfirmationModal {
                    ZStack {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                        
                        CustomConfirmationComponent(confirmType: .evacuated, isModalVisible: $showConfirmationModal, sosGuideModalVisible: $isShowingModal) {
                            // Dismiss the modal and perform the action
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    isShowingModal = false
                                }
                            
                            Task {
                                await viewModel.updateSessionDone()
                                navigateViewModel.isNavigating = false
                                navigateViewModel.stopTimer()
                                SOSManager.shared.isSOS = false
                                navigateViewModel.isSOS = false
    
//                                mountainViewModel.toggleIsPresenting()
//                                mountainViewModel.toggleIsPresenting()
                                mountainViewModel.isPresenting = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                showConfirmationModal = false
                                }
                            
                        }
                    }
                }
            }
            .environmentObject(navigationManager)
            .onAppear {
                viewModel.fetchEmergency()
                navigateViewModel.fileName = viewModel.trackId
//                viewModel.startTimer()
                navigateViewModel.isNavigating = true
                navigateViewModel.startTimer()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isShowingModal = true
                    }
            }
            .onChange(of: navigationManager.navigationPath) { newPath in
                if newPath.isEmpty {
                    isShowingModal = true
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
