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
}

struct EmergencyProsesView: View {
    @StateObject var viewModel = EmergencyProsesViewModel()
    @StateObject var navigateViewModel = UserNavigateViewModel(fileName: "")
    
    @EnvironmentObject var mountainViewModel : MountainsTracksViewModel
    
    @State var trackLocation: String?
    
    
    @State private var showSOSView = false
    
    @State private var navigateToDueDate = false
    
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some View {
        
        
        
        NavigationStack(path: $navigationManager.navigationPath) {
            
            VStack {
                
                ZStack (){
                    MapView(region: $navigateViewModel.region, waypoints: navigateViewModel.gpxParser.parsedWaypoints, track: navigateViewModel.gpxParser.parsedTrack, showsUserLocation: true, dots: navigateViewModel.dots, fileName: viewModel.trackId)
                        .zIndex(0)
                    
                    
                    VStack {
                        VStack {
                            
                            Text("\(viewModel.trackId)")
                            Text("\(trackLocation ?? "")")
                            
                            Button("Testing") {
                                navigateViewModel.updateTrackId(viewModel.trackId)
                                print("Track ID updated to: \(viewModel.trackId)")
                            }

                            
                            TopETAView(navigateViewModel: navigateViewModel)
                            
                            //INSERT NAVIGATION LINK HERE
                            // buat yang di bawah
                            
                            HStack {
                                Text("Due date")
                                    .font(.headline)
                                Text("30-45 min")
                                    .font(.subheadline)
                                Spacer()
                                Text("->")
                                    .font(.subheadline)
                            }
                            .padding()
                            
                            .onTapGesture {
                                navigationManager.navigationPath.append(DestinationView.editDueDate)
                            }
                            
                            HStack{
                                Text("name: \(viewModel.userName)")
                                Text("status: \(viewModel.status)")
                                
                            }
                            
                            Text("session id: \(viewModel.sessionId)")
                            Text("due: \(viewModel.dueDate)")
                            
                            if viewModel.sendSOSToFirebase{
                                Text("Your SOS signal is being sent, stay calm.")
                                
                            }
                            
                            
                            
                        }
                        .background(Color.white)
                        .zIndex(1)
                        
                        Spacer()
                    }
                    
                    
                    SOSButtonView(navigationPath: $navigationManager.navigationPath)
                        .offset(x: viewModel.showSOSButtonView ? 0 : -UIScreen.main.bounds.width)
                        .animation(viewModel.deleteAnimation ? nil : .easeInOut(duration: 0.5), value: viewModel.showSOSButtonView)
                        .zIndex(2)
                    
                }
                
                
                
                
                VStack{
                    
                    Button("I am back at basecamp"){
                        Task{
                            await viewModel.updateSessionDone()
                            navigateViewModel.isNavigating = false
                            navigateViewModel.stopTimer()
                            
                            
                            mountainViewModel.toggleIsPresenting()
                            
                            
                        }
                    }
                    
                    HStack{
                        Button(action: {
                            // Guide action
                            navigationManager.navigationPath.append(DestinationView.alertGuide)
                        }) {
                            Text("Guide")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        Spacer()
                        
                        
                        Button(action: {
                            // Toggle SOS View with animation
                            withAnimation {
                                viewModel.showSOSButtonView.toggle()
                            }
                        }) {
                            
                            Text(viewModel.showSOSButtonView ? "Map" : "SOS")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(viewModel.showSOSButtonView ? Color.blue : Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    
                }
                
                
            }
            .navigationDestination(for: DestinationView.self) { destination in
                switch destination {
                case .editDueDate:
                    EditDueDateView(viewModel: viewModel)
                case .chooseEmergency:
                    ChooseEmergencyTypeView(viewModel: viewModel)
                case .alertGuide:
                    AlertGuideView(viewModel: viewModel)
                case .countDown:
                    CountDownView(viewModel: viewModel)
                }
            }
            .onAppear{
                viewModel.deleteAnimation = false
                navigateViewModel.setupRegionUser()
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
