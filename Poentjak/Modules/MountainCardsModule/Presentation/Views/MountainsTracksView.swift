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
    
    @State  var isSearchActive = false
    @State private var selectedTrack: String?
    @State private var selectedSearchResult: MountainTracksModel?
    
    @Environment(\.isSearching) private var isSearching
    
    @FocusState private var isSearchFocused: Bool
    
    var searchResult: [MountainTracksModel]{
        if searchMountain.isEmpty || !viewModel.mountainsTracks.contains(where: { $0.name.localizedCaseInsensitiveContains(searchMountain) }){
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
                

//                MapView(region: $navigateViewModel.region, waypoints: navigateViewModel.gpxParser.parsedWaypoints, track: navigateViewModel.gpxParser.parsedTrack, showsUserLocation: true, dots: navigateViewModel.dots, fileName: "")
                
                MKMapViewRepresentable()

                
                //                    .zIndex(0)
                
                    .navigationDestination(for: MountainDestinationView.self) { destination in
                        switch destination {
                        case .mountainTracksDetail(let mountain):
                            MountainTracksDetailView(
                                mountain: mountain,
                                navigationManager: navigationManager,
                                viewModel: viewModel,
                                isShowingModal: $isShowingModal)
                                .environmentObject(viewModel)
                                .environmentObject(navigationManager)
                        case .tracksDetail(let track):
                            TracksDetailView(track: track, navigationManager: navigationManager, isShowingModal: $isShowingModal, viewModel: EmergencyProsesViewModel(), navigateViewModel: TracksMapViewModel(fileName: track), authViewModel: authViewModel)
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
                    .onChange(of: navigationManager.navigationPath) { newPath in
                        if newPath.isEmpty {
                            DispatchQueue.main.async {
                                isShowingModal = true
                            }
                        }
                    }.sheet(isPresented: $isShowingModal) {
                        NavigationStack {
                            VStack(alignment: .leading) {
                                if let mountain = selectedSearchResult{
                                    MountainTracksDetailView(mountain: mountain, navigationManager: navigationManager, viewModel: viewModel, isShowingModal: $isShowingModal)
                                }
                                else{
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
                            }
                            .padding(.vertical, 8)
                            .presentationDetents([.fraction(0.4)], selection: $selectedDetent)
                            .presentationDragIndicator(.visible)
                            .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.4)))
                            .interactiveDismissDisabled(true)
                        }
                    }
                   
                
            }
            
        }
//        .searchable(text: $searchMountain,
//                    tokens: $selectedTokens,
//                    suggestedTokens: $suggestedTokens,
//                    isPresented: $isSearchActive,
//                    placement: .automatic,
//                    prompt: "Find Mountains",
//                    token: { temp in
//            Text(temp.name)
//        })
        
        
        //        {_ in
//                    ForEach(searchResult, id: \.self) {
//                        result in
//                        Button{
//                            navigationManager.navigationPath.append(MountainDestinationView.mountainTracksDetail(mountain: result))
//                        }label: {
//                            SearchMountainCardComponent(mountain: result.name, streetName: result.streetName)
//                        }
//                    }
        //        }
        .searchable(text: $searchMountain, isPresented: $isSearchActive, prompt: "Find Mountains")
        .searchable(text: $searchMountain, prompt: "Find Mountains"){
            ForEach(searchResult, id: \.self) {
                result in
                Button{
                    isShowingModal = true
                    selectedSearchResult = result
//                    navigationManager.navigationPath.append(MountainDestinationView.mountainTracksDetail(mountain: result))
                }label: {
                    SearchMountainCardComponent(mountain: result.name, streetName: result.streetName)
                }
            }
        }
//        .focused($isSearchFocused)
        .onChange(of: isSearchActive){
            
            if isSearchActive == true{
                isShowingModal = false
            }else{
                selectedSearchResult = nil
                isShowingModal = true
            }
        }
        .ignoresSafeArea()
        .environmentObject(navigationManager)
        
        
        
//                        .searchable(text: $searchMountain, prompt: "Find Mountains"){
//        
//                                    ForEach(searchResult, id: \.self) {
//                                        result in
//                                        Button{
//                                            navigationManager.navigationPath.append(MountainDestinationView.mountainTracksDetail(mountain: result))
//                                        }label: {
//                                            SearchMountainCardComponent(mountain: result.name, streetName: result.streetName)
//                                        }
//                                    }
//        
//                        }
        
        
        
        
        
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



