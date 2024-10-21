//
//  ContentView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 23/09/24.
//

import SwiftUI

enum EmergencyStatusEnum: String, CaseIterable {
    case all = "All"
    case danger = "New"
    case ongoing = "Ongoing"
    case completed = "Completed"
}


struct ActiveEmergencyView: View {
    @StateObject private var viewModel = UserViewModel(activeEmergencyUseCase: ActiveEmergencyUseCase(activeEmergencyRepository: ActiveEmergencyRepository(), userRepository: DefaultUserRepository()))
    //    @State private var activeEmergencies = [UserModel]()
    //    let hikers
    
    @State var selectedUser: EmergencyRequestModel?
    @State private var isDetailViewActive = false
    @State private var idContainer: String = ""
    @StateObject var authViewModel: AuthViewModel
    
    @State private var selectedCondition: EmergencyStatusEnum = .danger
    
    
    var body: some View {
        
        NavigationView {
            VStack{
                Picker("Select Condition", selection: $selectedCondition) {
                    ForEach(EmergencyStatusEnum.allCases, id: \.self) { condition in
                        Text(condition.rawValue).tag(condition)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List {
                    HikersNeedHelpSectionComponent(hikers: filteredHikers()){ hiker in
                        viewModel.rescuing(id: hiker.id)
                        selectedUser = hiker
                        idContainer = hiker.id
                        isDetailViewActive = true
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                    .buttonStyle(PlainButtonStyle())

                    
                    //                    RangerRescuingSectionComponent(hikers: filteredHikers()){
                    //                        hiker in
                    //                        //                    viewModel.rescuing(id: hiker.id)
                    //                        selectedUser = hiker
                    //                        idContainer = hiker.id
                    //                        isDetailViewActive = true
                    //                    }
                    
                    
                }
                .padding()
                .navigationBarBackButtonHidden()
                .navigationTitle("Active Emergencies")
                .listStyle(PlainListStyle())

                
                
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
                
                .onAppear {
                    viewModel.fetchActiveEmergencyByTrack()
                    viewModel.fetchCompleteRescue()
                    //                viewModel.fetchDangerHiker()
                    viewModel.startTimer()
                }
                .onDisappear {
                    viewModel.stopTimer()
                }
                .background(
                    NavigationLink(
                        destination: AdminEmergencyDetailView(viewModel:DIContainer().makeAdminEmergencyViewModel(), mapViewModel: RangerMapViewModel(fileName: selectedUser?.user?.trackId ?? "gede1") ,emergencyRequestId: idContainer),
                        isActive: $isDetailViewActive,
                        label: { EmptyView() }
                    )
                )
                
            }
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    HStack{
//                        VStack(alignment: .leading) {
//                            Text(viewModel.formattedDate())
//                                .font(.headline)
//                                .foregroundColor(.gray)
//                                .font(.footnoteRegular)
//                            Text("Active Emergencies")
//                                .font(.title1Emphasized)
//                                .bold()
//                        }
//                        .padding()
//                        Spacer()
//                    }
//                    
//                }
//                
//            }
        }
        .ignoresSafeArea()
        
        
        
    }
    
    func filteredHikers() -> [EmergencyRequestModel] {
        switch selectedCondition {
        case .danger:
            return viewModel.hiker.filter { $0.emergencyStatus == "danger" }
        case .ongoing:
            return viewModel.hiker.filter { $0.emergencyStatus == "ongoing" }
        case .completed:
            return viewModel.completeRescue
        default:
            return viewModel.hiker.filter { $0.emergencyStatus != "safe"}
        }
    }
    
    
    
}

#Preview {
    ActiveEmergencyView(authViewModel: AuthViewModel(useCase: DefaultAuthUseCase(authRepository: DefaultAuthRepository(), userRepository: DefaultUserRepository())))
}
