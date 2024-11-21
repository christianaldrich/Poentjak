//
//  SuggestedMountainComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 04/11/24.
//

import SwiftUI

struct SuggestedMountainComponent: View {
    @StateObject var viewModel = MountainsTracksViewModel(mountainsTracksUseCase: MountainsTracksUseCase(mountainsTracksRepository: MountainsTracksRepository()), tracksUseCase: TracksUseCase(tracksRepository: TracksRepository()))
    @StateObject var navigationManager = MountainNavigationManager()
    @State private var isShowingModal = true
    @State private var selectedDetent = PresentationDetent.fraction(0.7)
    @Environment(\.isSearching) private var isSearching
    @StateObject var navigateViewModel = UserNavigateViewModel(fileName: "")



    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
//                Text(isSearching ? "search" : "not searching")
                Text("Suggested Mountains")
                    .font(.bodyEmphasized)
                    .foregroundStyle(Color.primaryGreen500)
                    .padding(.horizontal, 24)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.mountainsTracks, id: \.id) { mountain in
                            NavigationLink(destination: MountainTracksDetailView(mountain: mountain, navigationManager: navigationManager, viewModel: viewModel, isShowingModal: $isShowingModal, onBackButtonTapped: {})) {
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
            .presentationDragIndicator(.hidden)
            .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.4)))
            .interactiveDismissDisabled(true)
        }
        .onChange(of: isSearching){
            isShowingModal = false
        }
    }
}

#Preview {
    SuggestedMountainComponent()
}
