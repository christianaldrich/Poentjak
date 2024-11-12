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
            .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 2)
            .scrollContentBackground(.hidden)
            
            HStack{
                Spacer()
                VStack{
                    HStack{
                        Text("Important :")
                            .font(.subheadlineRegular)
                            .fontWeight(.bold)
                            .foregroundColor(Color.errorRed500)
                            .multilineTextAlignment(.center)
                        Text("Make sure to not finish the")
                            .font(.subheadlineRegular)
                            .foregroundColor(Color.primaryGreen500)
                            .multilineTextAlignment(.center)
                    }
                    Text("trip before arriving back at the basecamp")
                        .font(.subheadlineRegular)
                        .foregroundColor(Color.primaryGreen500)
                        .multilineTextAlignment(.center)
                }
                Spacer()
            }
            
            HStack{
                Spacer()
                CustomLargeButtonComponent(state: .enabled, text: "I'm ready"){
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




//#Preview {
//    DueDateView(trackLocation: "", navigationManager: navigationmanag)
//}
