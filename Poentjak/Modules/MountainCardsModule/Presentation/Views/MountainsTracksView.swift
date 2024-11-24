//
//  MountainsTracksView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 08/10/24.
//

import SwiftUI
import BottomSheet

enum MountainDestinationView: Hashable {
    case mountainTracksDetail(mountain: MountainTracksModel?)
    case tracksDetail(tracks: String)
    case dueDate(trackLocation: String)
    case hikerProfile
    case editProfile
    case editGender
    case editEmergencyContact
    case editMedicalRecords
    case editAge
    case editWeight
    case editHeight
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
    @State private var selectedSearchResult: MountainTracksModel? = nil
    
    @Environment(\.isSearching) private var isSearching
    
    @FocusState private var isSearchFocused: Bool
    
    @State var bottomSheetPosition: BottomSheetPosition = .absolute(375)
    
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

            ZStack{
                
                MKMapViewRepresentable()
                
                    .toolbar{
                        ToolbarItem(placement: .topBarTrailing){
                            Button{
                                isShowingModal = false
                                navigationManager.navigationPath.append(MountainDestinationView.hikerProfile)
                            }label:{
                                Image.ButtonIcon.profileBig
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 39, height: 39)
                            }
                            
                        }
                        
                        ToolbarItem(placement: .topBarLeading){
                           
                            Text("Hikewise")
                                .font(.title1Emphasized)
                                .foregroundStyle(Color.primaryGreen500)
                            
                        }
                    }
                    .navigationDestination(for: MountainDestinationView.self) { destination in
                        switch destination {
                        case .mountainTracksDetail(let mountain):
                            MountainTracksDetailView(
                                mountain: mountain,
                                navigationManager: navigationManager,
                                viewModel: viewModel,
                                isShowingModal: $isShowingModal) {
                                    viewModel.selectedMountain = nil
                                }
                                .environmentObject(viewModel)
                                .environmentObject(navigationManager)
                        case .tracksDetail(let track):
                            TracksDetailView(track: track, navigationManager: navigationManager, isShowingModal: $isShowingModal, viewModel: EmergencyProsesViewModel(), navigateViewModel: TracksMapViewModel(fileName: track), authViewModel: authViewModel)
                                .environmentObject(viewModel)
                                .environmentObject(navigationManager)
                                .toolbar(.hidden, for: .tabBar)
                        case .dueDate(let trackLocation):
                            DueDateView(trackLocation: trackLocation)
                                .toolbar(.hidden, for: .tabBar)
                                .environmentObject(viewModel)
                                .environmentObject(navigationManager)
                        case .hikerProfile:
                            HikerProfileView(viewModel: HikerProfileViewModel(authViewModel: authViewModel, hikerProfileUseCase: HikerProfileUseCase(userRepository: DefaultUserRepository())), authViewModel: authViewModel, navigationManager: navigationManager, emergencyViewModel: EmergencyProsesViewModel())
                                .environmentObject(viewModel)
                                .environmentObject(navigationManager)
                                .toolbar(.hidden, for: .tabBar)
                            
                        case .editProfile:
                            EditProfileView(authViewModel: authViewModel, viewModel: HikerProfileViewModel(authViewModel: authViewModel, hikerProfileUseCase: HikerProfileUseCase(userRepository: DefaultUserRepository())), navigationManager: navigationManager)
                                .environmentObject(viewModel)
                                .environmentObject(navigationManager)
                        case .editGender:
                            EditGenderView(viewModel: authViewModel, navigationManager: navigationManager)
                                .environmentObject(viewModel)
                                .environmentObject(navigationManager)
                        case .editEmergencyContact:
                            EditEmergencyContactView(viewModel: authViewModel, navigationManager: navigationManager)
                                .environmentObject(viewModel)
                                .environmentObject(navigationManager)
                        case .editMedicalRecords:
                            EditMedicalRecordsView(viewModel: authViewModel, navigationManager: navigationManager)
                                .environmentObject(viewModel)
                                .environmentObject(navigationManager)
                        case .editAge:
                            EditNumberView(viewModel: authViewModel, navigationManager: navigationManager, state: .age)
                                .environmentObject(viewModel)
                                .environmentObject(navigationManager)
                        case .editWeight:
                            EditNumberView(viewModel: authViewModel, navigationManager: navigationManager, state: .weight)
                                .environmentObject(viewModel)
                                .environmentObject(navigationManager)
                        case .editHeight:
                            EditNumberView(viewModel: authViewModel, navigationManager: navigationManager, state: .height)
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
                    }
                    .bottomSheet(bottomSheetPosition: $bottomSheetPosition, switchablePositions: [.absolute(375)], content: {
                        ZStack {
                            
                            if viewModel.selectedMountain == nil {
                                
                                VStack(alignment: .leading) {
                                    Text("Suggested Mountains")
                                        .font(.bodyEmphasized)
                                        .foregroundStyle(Color.primaryGreen500)
                                        .padding(.horizontal, 24)
                                        .padding(.top, 8)
                                    

                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 16) {
                                            ForEach(viewModel.mountainsTracks, id: \.id) { mountain in
                                                Button {
                                                    withAnimation(.easeInOut) {
                                                        viewModel.selectedMountain = mountain
                                                        let trackIds = mountain.tracks.map { $0 }
                                                        viewModel.fetchTracksForSelectedMountain(trackIds: trackIds)
                                                    }
                                                } label: {
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
                                .transition(.move(edge: .leading)) // Push animation for entry
                            }

                            // MountainTracksDetailView
                            if let selectedMountain = viewModel.selectedMountain {
                                MountainTracksDetailView(
                                    mountain: selectedMountain,
                                    navigationManager: navigationManager,
                                    viewModel: viewModel,
                                    isShowingModal: $isShowingModal
                                ) {
                                    withAnimation(.easeInOut) {
                                        viewModel.selectedMountain = nil
                                    }
                                }
                                .transition(.move(edge: .trailing)) // Push animation for entry
                            }
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                        

                        
                    })
                    .sheetWidth(BottomSheetWidth.absolute(400))
                    .customBackground(
                        Color.neutralWhite
                                        .cornerRadius(16)
                                )
                    .showDragIndicator(false)
                
            }
            
            
        }
        
        .searchable(text: $searchMountain, isPresented: $isSearchActive, prompt: "Find Mountains")
        .searchable(text: $searchMountain, prompt: "Find Mountains"){
            ForEach(searchResult, id: \.self) {
                result in
                Button{
                    isShowingModal = true
                    //selectedSearchResult = result
                    viewModel.selectedMountain = result
//                    navigationManager.navigationPath.append(MountainDestinationView.mountainTracksDetail(mountain: result))
                }label: {
                    SearchMountainCardComponent(mountain: result.name, streetName: result.streetName)
                }
            }
        }
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



