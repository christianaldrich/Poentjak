//
//  MountainsTracksView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 08/10/24.
//

import SwiftUI

enum MountainDestinationView: Hashable {
    case mountainTracksDetail(mountain: MountainTracksModel?)
    case tracksDetail(tracks: String)
    case dueDate(trackLocation: String)
}



struct MountainsTracksView: View {
    @StateObject var viewModel = MountainsTracksViewModel(mountainsTracksUseCase: MountainsTracksUseCase(mountainsTracksRepository: MountainsTracksRepository()), tracksUseCase: TracksUseCase(tracksRepository: TracksRepository()))
    
    @StateObject var authViewModel: AuthViewModel
    @StateObject var navigationManager = MountainNavigationManager()
    
    
    @State private var searchMountain = ""
    @StateObject var navigateViewModel = UserNavigateViewModel(fileName: "")
    
    @State private var isShowingModal = true
    @State private var selectedDetent = PresentationDetent.fraction(0.7)
    
    
    @State private var selectedTrack: String?
    
    var searchResult: [MountainTracksModel] {
        if searchMountain.isEmpty {
            return viewModel.mountainsTracks
        } else {
            return viewModel.mountainsTracks.filter { mountain in
                mountain.name.localizedCaseInsensitiveContains(searchMountain)
            }
        }
    }
    
    var body: some View {
        
        NavigationStack(path: $navigationManager.navigationPath){
            //            List(viewModel.mountainsTracks, id: \.id){mountain in
            //                Button("Name: \(mountain.name)"){
            //                    navigationManager.navigationPath.append(MountainDestinationView.mountainTracksDetail(mountain: mountain))
            //                }
            //
            //
            //            }
            
            ZStack{
                
                MapView(region: $navigateViewModel.region, waypoints: navigateViewModel.gpxParser.parsedWaypoints, track: navigateViewModel.gpxParser.parsedTrack, showsUserLocation: true, dots: navigateViewModel.dots, fileName: "")
                    .zIndex(0)
                
                VStack{
                    Spacer()
                    Text("asdfasdf")
                        .background(.blue)
                    
                    
                    
                        .navigationTitle("Mountain Card")
                        .navigationDestination(for: MountainDestinationView.self) { destination in
                            switch destination {
                            case .mountainTracksDetail(let mountain):
                                MountainTracksDetailView(mountain: mountain, navigationManager: navigationManager, viewModel: viewModel, isShowingModal: $isShowingModal)
                                    .environmentObject(viewModel)
                                    .environmentObject(navigationManager)
                            case .tracksDetail(let track):
                                TracksDetailView(track: track, navigationManager: navigationManager, isShowingModal: $isShowingModal)
                                    .environmentObject(viewModel)
                                    .environmentObject(navigationManager)
                            case .dueDate(let trackLocation):
                                DueDateView(trackLocation: trackLocation)
                                    .environmentObject(viewModel)
                                    .environmentObject(navigationManager)
                            }
                        }
                        .fullScreenCover(isPresented: $viewModel.isPresenting) {
                            EmergencyProsesView(navigateViewModel: UserNavigateViewModel(fileName: viewModel.selectedTrackLocation))
                                .environmentObject(viewModel)
                        }
                    
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
                    
                    .onChange(of: navigationManager.navigationPath) { newPath in
                        if newPath.isEmpty {
                            DispatchQueue.main.async {
                                isShowingModal = true
                            }
                        }
                    }
                    .sheet(isPresented: $isShowingModal) {
                        NavigationStack {
                            VStack(alignment: .leading) {
                                Text("Suggested Mountains")
                                    .font(.bodyEmphasized)
                                    .foregroundStyle(Color.primaryGreen500)
                                    .padding(.horizontal, 24)
                                
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(viewModel.mountainsTracks, id: \.id) { mountain in
                                            NavigationLink(destination: MountainTracksDetailView(mountain: mountain, navigationManager: navigationManager, viewModel: viewModel, isShowingModal: $isShowingModal)) {
                                                VStack(alignment: .leading) {
                                                    Image(mountain.imageURL)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 205, height: 150)
                                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                                    
                                                    Text(mountain.name)
                                                        .font(.subheadlineRegular)
                                                        .foregroundStyle(Color.primaryGreen500)
                                                    
                                                }
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 24)
                                    
                                }
                                .padding(.top, 8)
                            }
                            .padding(.vertical, 8)
                            .presentationDetents([.fraction(0.4)], selection: $selectedDetent)
                            .presentationDragIndicator(.visible)
                            .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.4)))
                            .interactiveDismissDisabled(true)
                        }
                    }
                    
                    .environmentObject(navigationManager)
                    .searchable(text: $searchMountain, prompt: "Find Mountains"){
                        ForEach(searchResult, id: \.self) {
                            result in
                            Button{
                                navigationManager.navigationPath.append(MountainDestinationView.mountainTracksDetail(mountain: result))
                            }label: {
                                SearchMountainCardComponent(mountain: result.name, streetName: result.streetName)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
}

class MountainNavigationManager: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    func popToPrevious() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
}
