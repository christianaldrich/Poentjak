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
    @State private var dangerCount = 0

    //    var activateNotif = RangerPushNotification()
    
    
    var body: some View {
        
        //        NavigationView {
        VStack{
            
            Picker("Select Condition", selection: $selectedCondition) {
                ForEach(EmergencyStatusEnum.allCases, id: \.self) { condition in
                    Text(condition.rawValue).tag(condition)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            //            if viewModel.hiker.isEmpty{
            
            //            }else{
            
            if filteredHikers().isEmpty && selectedCondition != .completed{
                
                NoActiveEmergenciesView()
                
            }else{
                List {
                    HikersNeedHelpSectionComponent(hikers: filteredHikers(), authViewModel: authViewModel){ hiker in
                        
                        selectedUser = hiker
                        idContainer = hiker.id
                        isDetailViewActive = true
                    }
                    .listRowSeparator(.hidden)
                    //                    .listRowInsets(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                    .buttonStyle(PlainButtonStyle())
                    
                }
            }
            //                .padding()
            
            //            }
            
            
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Active Emergencies")
        .listStyle(PlainListStyle())
        .onAppear {
            
            NotificationManager.instance.requestAuth()
            viewModel.fetchActiveEmergencyByTrack()
            
            viewModel.fetchCompleteRescue()
            //                viewModel.fetchDangerHiker()
            viewModel.startTimer()
            UNUserNotificationCenter.current().setBadgeCount(0)
        }
        //        .onChange(of: dangerCount){
        //            print("jumlah skrg: \(dangerCount)")
        //            viewModel.fetchActiveEmergencyByTrack()
        //        }
        .onChange(of: filteredHikers().filter { $0.emergencyStatus == "danger" }.count) {
//            let temp = filteredHikers().filter { $0.emergencyStatus == "danger" }.count
//            print("\n\nFILTERED DANGER HIKERS : \(filteredHikers().filter { $0.emergencyStatus == "danger" })")
//            print("Danger hikers count changed to: \(dangerCount)")
//            if temp > dangerCount {
                viewModel.startNotify(filteredHikers().filter { $0.emergencyStatus == "danger" })
//            }
            
//            dangerCount = temp
            
        }
        
        .onDisappear {
            viewModel.stopTimer()
        }
        .background(
            NavigationLink(
                destination: AdminEmergencyDetailView(viewModel:DIContainer().makeAdminEmergencyViewModel(), mapViewModel: RangerMapViewModel(fileName: selectedUser?.user?.trackId ?? "gede1") ,emergencyRequestId: idContainer, authViewModel: authViewModel),
                isActive: $isDetailViewActive,
                label: { EmptyView() }
            )
        )
        
        
        
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

//#Preview {
//    ActiveEmergencyView(authViewModel: AuthViewModel(useCase: DefaultAuthUseCase(authRepository: DefaultAuthRepository(), userRepository: DefaultUserRepository())))
//}
