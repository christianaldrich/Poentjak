//
//  MountainTracksDetailView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 08/10/24.
//

import SwiftUI

struct MountainTracksDetailView: View {
    let mountain: MountainTracksModel?
    @ObservedObject var navigationManager: MountainNavigationManager
    @ObservedObject var viewModel: MountainsTracksViewModel
    @Binding var isShowingModal: Bool
    
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isMountainCardPresented = false
    
    @EnvironmentObject var mountainViewModel : MountainsTracksViewModel



    var body: some View {
        VStack(alignment: .leading) {
            if let mountain = mountain {
                HStack {
                    Button(action: {
//                        navigationManager.popToRoot()
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 10, height: 18)
                            .foregroundStyle(.black)
                    }
                    .padding(.leading, 24)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Your current location")
                            .font(.footnoteRegular)
                            .foregroundStyle(Color.primaryGreen500)
                        
                        HStack {
                            Image.ExploreIcon.mountainSmall
                            Text(mountain.name)
                                .font(.bodyEmphasized)
                                .foregroundStyle(Color.primaryGreen500)
                        }
                    }
                    
                    Spacer()
                    Spacer()
                    
                    Button {
                        isMountainCardPresented = true
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.neutralGrayTertiaryGray)
                            .padding(.bottom, 16)
                    }
                    .sheet(isPresented: $isMountainCardPresented) {
                        NavigationStack {
                            MountainCardComponent(mountain: mountain)
                                .toolbar {
                                    ToolbarItem(placement: .cancellationAction) {
                                        Button{
                                            isMountainCardPresented = false
                                        }label:{
                                            Image(systemName: "chevron.left")
                                                .resizable()
                                                .frame(width: 10, height: 18)
                                                .foregroundStyle(.black)
                                        }
                                    }
                                }
                        }
                        .presentationDetents([.fraction(0.55), .large])
                    }
                    
//                    NavigationLink(destination: MountainCardComponent(mountain: mountain)){
//                        Image(systemName: "info.circle.fill")
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                            .foregroundStyle(Color.neutralGrayTertiaryGray)
//                            .padding(.bottom, 16)
//                    }
                    
                        
                    
                    
                }
                .padding(.horizontal, 24)
                .onAppear {
                    let trackIds = mountain.tracks.map { $0 }
                    viewModel.fetchTracksForSelectedMountain(trackIds: trackIds)
                }
                
                HStack {
                    Image.ExploreIcon.track
                    Text("\(viewModel.selectedTracks.count) tracks available")
                        .font(.footnoteRegular)
                        .foregroundStyle(Color.primaryGreen500)
                }
                .padding(.horizontal, 24)

                // Horizontal ScrollView for tracks
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        if !viewModel.selectedTracks.isEmpty {
                            ForEach(viewModel.selectedTracks, id: \.self) { track in
                                Button(action: {
//                                    mountainViewModel.selectedTrackLocation = track.id
                                    
                                    navigationManager.navigationPath.append(MountainDestinationView.tracksDetail(tracks: track.id))
                                    isShowingModal = false
                                }) {
                                    VStack(alignment: .leading) {
                                        Image(track.imageURL)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 205, height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                        
                                        Text(track.name)
                                            .font(.subheadlineRegular)
                                            .foregroundStyle(Color.primaryGreen500)
                                            
                                    }
                                }
                            }
                        } else {
                            Text("No tracks available.")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 24)
                }
                
                
            } else {
                Text("No mountain details available.")
            }
        }
        .navigationBarBackButtonHidden(true) // Hide default back button
        .navigationTitle("") // Remove default title
    }
}
