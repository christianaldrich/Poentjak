//
//  Untitled.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 07/10/24.
//

import SwiftUI

struct ActiveHikersView: View {
    
    @StateObject var viewModel : ActiveHikersViewModel
    //(activeHikersUseCase: ActiveHikersUseCase(activeHikersRepository: ActiveHikersRepository(), userRepository: DefaultUserRepository()))
    
    @State var selectedUser: EmergencyRequestModel?
    @State private var isDetailViewActive = false
    
    @State private var selectedDetent = PresentationDetent.fraction(0.65)
    
    @StateObject var authViewModel: AuthViewModel
    @State var isShowLogoutModal: Bool = false
    @State var sosGuideModalVisible: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack {
                if viewModel.activeHikers.isEmpty {
                    Text("No active hikers")
                        .font(.headline)
                        .padding()
                } else {
                    
                    List(viewModel.activeHikers, id: \.id) { hiker in
                        
                        Button(action: {
                            selectedUser = hiker
                            isDetailViewActive = true
                        }) {
                            ActiveHikersCardComponent(name: hiker.user?.name ?? "",
                                                      gender: hiker.user?.gender ?? "",
                                                      dueDate: hiker.dueDate,
                                                      viewModel: viewModel, authViewModel: authViewModel)
                            //                            .padding(.vertical)
                            
                            
                        }
                        .buttonStyle(PlainButtonStyle())
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                        
                        
                        
                    }
                    
                    .listStyle(PlainListStyle())
                }
            }
            .padding()
            
            .navigationTitle("Active Hikers: \(viewModel.activeHikers.count)")
            .sheet(item: $selectedUser) { hiker in
                ActiveHikersDetailView(hiker: hiker, viewModel: viewModel, authViewModel: authViewModel)
                    .presentationDetents([.fraction(0.65)], selection: $selectedDetent)
                    .presentationDragIndicator(.visible)
//                    .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.65)))
                //                    .interactiveDismissDisabled(true)
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button(action: {
                    Task {
                        // await authViewModel.signOut()
                        isShowLogoutModal = true
                    }
                }) {
                    Image.LabelIcon.signOut
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.primaryGreen500)
                }
                .disabled(isShowLogoutModal)
            }
        }
        .overlay{
            if isShowLogoutModal {
                ZStack {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    
                    CustomConfirmationComponent(confirmType: .logout, isModalVisible: $isShowLogoutModal, sosGuideModalVisible: $sosGuideModalVisible) {
                        Task {
                            await authViewModel.signOut()
                        }
                    }
                }

            }
        }
        
    }
}



