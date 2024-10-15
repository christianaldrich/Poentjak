//
//  EmergencyProsesView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 29/09/24.
//

import SwiftUI

enum DestinationView {
    case editDueDate
    case chooseEmergency
    case alertGuide
    case countDown
}

struct EmergencyProsesView: View {
    // @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = EmergencyProsesViewModel()
    @StateObject var navigateViewModel = UserNavigateViewModel(fileName: "")
    @State var tracklocation: String?
    
    
    //    @State private var showSOSView = false
    @State private var navigateToDueDate = false // State to navigate to EditDueDateView
    
    
    @StateObject private var navigationManager = NavigationManager() // Initialize navigation manager
    
    
    var body: some View {
        
//        NavigationStack(path: $navigationManager.navigationPath) {
            VStack {
                
                ZStack (){
                    // Map View always in the background
                    //                                                        UserNavigateView(viewModel: navigateViewModel)
                    //                        .zIndex(0)
//                    DummyMapView()
                    MapView(region: $navigateViewModel.region, waypoints: navigateViewModel.gpxParser.parsedWaypoints, track: navigateViewModel.gpxParser.parsedTrack, showsUserLocation: true, dots: navigateViewModel.dots, fileName: tracklocation)
                        .zIndex(0)
                    
                    VStack {
                        VStack {
                            // Top View
                            HStack {
                                Text("Pos 1")
                                    .font(.headline)
                                Text("30-45 min")
                                    .font(.subheadline)
                                Spacer()
                                Text("->")
                                    .font(.subheadline)
                            }
                            .padding()
                            
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
//                            .onTapGesture {
//                                navigationManager.navigationPath.append(DestinationView.editDueDate)
////                                navigationManager.navigationPath.append("EditDueDateView")
//                                //                                navigateToDueDate = true // Trigger navigation
//                            }
                            
                            HStack{
                                Text("name: \(viewModel.userName)")
                                Text("status: \(viewModel.status)")
                                
                            }
                            
                            Text("session id: \(viewModel.sessionId)")
                            Text("due: \(viewModel.dueDate)")
                            Text(String(format: "%02d:%02d:%02d",
                                        Int(navigateViewModel.elapsedTime) / 3600,
                                        (Int(navigateViewModel.elapsedTime) % 3600) / 60,
                                        Int(navigateViewModel.elapsedTime) % 60))
                            
                            if viewModel.sendSOSToFirebase{
                                Text("Your SOS signal is being sent, stay calm.")
                                
                            }
                            
                        }
                        .background(Color.white)
                        .zIndex(1)
                        
                        Spacer()
                    }
                    
                    // SOS View that slides in from the left
//                    SOSButtonView()
//                        .offset(x: viewModel.showSOSButtonView ? 0 : -UIScreen.main.bounds.width)
//                        .animation(viewModel.deleteAnimation ? nil : .easeInOut(duration: 0.5), value: viewModel.showSOSButtonView)
//                        .zIndex(2)
                }
                
                //bottom view
                VStack{
                    Button("I am back at basecamp"){
                        Task{
                            await viewModel.updateSessionDone()
                            navigateViewModel.isNavigating = false
                            navigateViewModel.stopTimer()
                            navigateViewModel.locationManager.resetTotalDistance()
                        }
                    }
                    
                    HStack{
                        Button(action: {
                            // Guide action
                        }) {
                            Text("Guide")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        Spacer()
                        
                        NavigationLink{
                            SOSButtonView(sessionId: viewModel.sessionId)
                        }label: {
                            Text(viewModel.showSOSButtonView ? "Map" : "SOS")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(viewModel.showSOSButtonView ? Color.blue : Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
//                        Button(action: {
//                            // Toggle SOS View with animation
//                            withAnimation {
//                                viewModel.showSOSButtonView.toggle()
//                            }
//                        }) {
//                            Text(viewModel.showSOSButtonView ? "Map" : "SOS")
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(viewModel.showSOSButtonView ? Color.blue : Color.red)
//                                .foregroundColor(.white)
//                                .cornerRadius(8)
//                        }
                    }
                    .padding()
                    
                }
                
                
            }

//            .navigationDestination(for: DestinationView.self) { destination in
//                switch destination {
//                case .editDueDate:
//                    EditDueDateView(viewModel: viewModel)
//                case .chooseEmergency:
//                    ChooseEmergencyTypeView(viewModel: viewModel)
//                case .alertGuide:
//                    AlertGuideView(viewModel: viewModel)
//                case .countDown:
//                    CountDownView(viewModel: viewModel)

            
//            UserNavigateView(viewModel: navigateViewModel)
//                .frame(width: 700, height: 700)
            
//            Text("This is hiking session")
//            
//            Text(viewModel.status)
//                .padding()
//            Text(viewModel.userName)
//                .padding()
//            Text("\(viewModel.dueDate)")
//                .padding()
//            Text("\(viewModel.sessionId)")
//                .padding()
//            MapView()
            

//            
//            Text("edit time")
//            
//            Text("SOS")
//            
////            Text("I am back at basecamp")
//            Button("I am back at basecamp"){
//                Task{
//                    await viewModel.updateSessionDone()
//                    navigateViewModel.isNavigating = false
//                    navigateViewModel.stopTimer()
//                    navigateViewModel.locationManager.resetTotalDistance()
//                    
////                    print("\(viewModel.sessionId)")
////                               presentationMode.wrappedValue.dismiss()
//                           
//                }
//            }
            
//            Button("Delete Emergency") {
//                Task {
//                    await viewModel.deleteEmergency()
//                    presentationMode.wrappedValue.dismiss()
//                }
//            }
            //            .navigationDestination(for: String.self) { destination in
            //                if destination == "EditDueDateView" {
            //                    EditDueDateView(viewModel: viewModel)
            //                } else if destination == "ChooseEmergencyView" { ChooseEmergencyTypeView(viewModel: viewModel)
            //                } else if destination == "AlertGuideView" {
            //                    AlertGuideView(viewModel: viewModel)
            //                } else if destination == "CountDownView" {
            //                    CountDownView(viewModel: viewModel)
            //                }
            //            }
            .onAppear{
                viewModel.deleteAnimation = false
                navigateViewModel.setupRegionUser()
            }
            
            
//        }
//        .environmentObject(navigationManager)
        .onAppear{
            viewModel.fetchEmergency()
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
    }
}
