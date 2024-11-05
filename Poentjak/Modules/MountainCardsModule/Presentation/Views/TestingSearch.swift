////
////  TestingSearch.swift
////  Poentjak
////
////  Created by Christian Aldrich Darrien on 31/10/24.
////
//
//import SwiftUI
//
//struct TestingSearch: View {
//    
//    @StateObject var viewModel = MountainsTracksViewModel(mountainsTracksUseCase: MountainsTracksUseCase(mountainsTracksRepository: MountainsTracksRepository()), tracksUseCase: TracksUseCase(tracksRepository: TracksRepository()))
//    
//    @State private var searchMountain = ""
//    
//    @StateObject var navigationManager = MountainNavigationManager()
//    
//    @StateObject var navigateViewModel = UserNavigateViewModel(fileName: "")
//
//
//    
//    var searchResult: [MountainTracksModel] {
//        if searchMountain.isEmpty {
//            return viewModel.mountainsTracks
//        } else {
//            return viewModel.mountainsTracks.filter { mountain in
//                mountain.name.localizedCaseInsensitiveContains(searchMountain)
//            }
//        }
//    }
//    
//    var body: some View {
//        
//        NavigationStack(path: $navigationManager.navigationPath){
//            ZStack{
//                
//                List(viewModel.mountainsTracks, id: \.id){mountain in
//                    Button("Name: \(mountain.name)"){
//                        navigationManager.navigationPath.append(MountainDestinationView.mountainTracksDetail(mountain: mountain))
//                    }
//                }
//                .navigationDestination(for: MountainDestinationView.self){ destination in
//                    switch destination{
//                    case .mountainTracksDetail(let mountain):
//                        MountainTracksDetailView(mountain: mountain, navigationManager: navigationManager)
//                            .environmentObject(viewModel)
//                            .environmentObject(navigationManager)
//                        
//                    case .tracksDetail(let track):
//                        TracksDetailView(track: track, navigationManager: navigationManager)
//                            .environmentObject(viewModel)
//                            .environmentObject(navigationManager)
//                        
//                    case .dueDate(let trackLocation):
//                        DueDateView(trackLocation: trackLocation)
//                            .environmentObject(viewModel)
//                            .environmentObject(navigationManager)
//                    }
//                    
//                }
//                .fullScreenCover(isPresented: $viewModel.isPresenting){
//                    EmergencyProsesView(navigateViewModel: UserNavigateViewModel(fileName: viewModel.selectedTrackLocation))
//                        .environmentObject(viewModel)
//                    
//                }
//            }
//        }
//        .environmentObject(navigationManager)
//        .searchable(text: $searchMountain, prompt: "Find Mountains"){
//            ForEach(searchResult, id: \.self) {
//                result in
//                Button{
//                    navigationManager.navigationPath.append(MountainDestinationView.mountainTracksDetail(mountain: result))
//                }label: {
//                    SearchMountainCardComponent(mountain: result.name, streetName: result.streetName)
//                }
//            }
//        }
//        
//    }
//}
//
//#Preview {
//    TestingSearch()
//}
