//
//  DueDateView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 02/10/24.
//


import SwiftUI

struct DueDateView: View {
    @StateObject var viewModel = EmergencyProsesViewModel()
    
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    @State private var navigateToEmergencyProcess = false // State for navigation
    @State private var navigateToTracking = false
    @State var trackLocation: String
    
    @State private var isDateSelected = false
    
    var formattedDueDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E d MMM HH.mm" // "E" for day (Mon), "d" for day number, "MMM" for month, "HH.mm" for time
        return formatter.string(from: viewModel.dueDate)
    }
    
    @EnvironmentObject var mountainViewModel : MountainsTracksViewModel
    
    @EnvironmentObject var navigationManager : MountainNavigationManager
    
    var body: some View {
        
        VStack (alignment: .leading){
            
            Text("Tell us when you will be back")
                .font(.title3Emphasized)
                .foregroundColor(Color.primaryGreen500)
                .padding(.horizontal, 24)
                .padding(.top, 8)
            
            Text("When overdue, we will alert rangers in case of emergency.")
                .font(.subheadlineRegular)
                .foregroundColor(Color.primaryGreen500)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 24)
                .padding(.top, 0.5)
            
            List {
                DisclosureGroup() {
                    VStack {
                        HStack {
                            Spacer()
                            CustomDateSliderComponent(selectedDate: $viewModel.dueDate)
                                .onChange(of: viewModel.dueDate) { _ in
                                                                isDateSelected = true // User has selected a date
                                                            }
                            Spacer()
                        }
                    }
                    
                } label: {
                    HStack {
                        Text("Arrival Date")
                            .font(Font.subheadlineRegular)
                            .foregroundStyle(Color.primaryGreen500)
                        Spacer()
                        Text(formattedDueDate)
                            .font(.subheadlineRegular)
                            .foregroundStyle(Color.primaryGreen500)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                    .alignmentGuide(.listRowSeparatorTrailing) { d in
                        d[.trailing] + 16
                    }
                }
                //.padding(.horizontal, 16) // Consistent padding for each row
                .animation(.easeOut, value: 1)
                .accentColor(.primaryGreen500)
            }
            //.listStyle(PlainListStyle()) // Add this line
            .customShadow()
            .scrollContentBackground(.hidden)
           
            
            HStack{
                Spacer()
                CustomLargeButtonComponent(state: isDateSelected ? .enabled : .disabled, text: "I'm ready"){
                    Task{
                        mountainViewModel.selectedTrackLocation = trackLocation
                        await viewModel.createEmergencyHiking(trackId: trackLocation)
//                        mountainViewModel.toggleIsPresenting()
                        mountainViewModel.isPresenting = true
                        navigationManager.popToRoot()
                    }
                }
                .padding(.horizontal, 24)
                Spacer()
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                BackButtonComponent{
                    
                }
            }
        }
    }
}


#Preview {
    DueDateView(trackLocation: "Sample Track Location")
        .environmentObject(
            MountainsTracksViewModel(
                mountainsTracksUseCase: MountainsTracksUseCase(mountainsTracksRepository: MountainsTracksRepository()),
                tracksUseCase: TracksUseCase(tracksRepository: TracksRepository())
            )
        )
        .environmentObject(MountainNavigationManager())
}

