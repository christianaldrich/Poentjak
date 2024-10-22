//
//  ActiveHikersDetailView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 07/10/24.
//

import SwiftUI

struct ActiveHikersDetailView: View {
    let hiker: EmergencyRequestModel?
    @StateObject var viewModel = ActiveHikersViewModel(activeHikersUseCase: ActiveHikersUseCase(activeHikersRepository: ActiveHikersRepository(), userRepository: DefaultUserRepository()))
    @Environment(\.dismiss) var dismiss
    
    @State private var isContactActive = false
    
    
    
    
    var body: some View {
        
        VStack(spacing: 16){
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        
                        Image("profPic")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 86,height: 83)
                            .clipShape(RoundedRectangle(cornerRadius: 17))
                        
                        VStack(alignment: .leading){
                            HStack{
                                Text("\(hiker?.user?.name ?? "")")
                                viewModel.customGender(hiker?.user?.gender ?? "")
                            }
                            .font(.headlineRegular)
                            Text(minutesAgo(from: hiker?.dueDate ?? Date()))
                                .font(.caption1Regular)
                                .foregroundStyle(Color.neutralGrayTertiaryGray)
                        }
                        
                        
                    }
                    
                    
                    Text("Arrived by \(viewModel.dateFormatter(input: hiker?.dueDate ?? Date()))")
                }
                .padding(.leading)
                Spacer()
            }
//            .padding()
            
            CustomLongRectangleDetail(type: .note(text: hiker?.user?.medicalRecord ?? "None"))

            EmergencyContactButton(value: hiker?.user?.contactName ?? ""){
                isContactActive = true
            }
            
            Divider()
            HStack{
                CustomLabelGeneral(type: .hikerDetailData(type: .age(hiker?.user?.age ?? 0)))
                Spacer()
                CustomLabelGeneral(type: .hikerDetailData(type: .weight(hiker?.user?.weight ?? 0)))
                Spacer()
                CustomLabelGeneral(type: .hikerDetailData(type: .height(hiker?.user?.height ?? 0)))
            }
            .padding()
            
            Divider()
            
            CustomPrimaryButtonComponent(state: .enabled, text: "Clock out hiker"){
                Task{
                    await viewModel.updateHikerSession(userId: hiker?.user?.id ?? "")
                }
                dismiss()
            }
            
        }
        .padding(.top,20)
        .padding()
        .sheet(isPresented: $isContactActive) {
            // Modal content (EmergencyContactViewComponent)
            EmergencyContactViewComponent(
                contactName: hiker?.user?.contactName ?? "Unknown",
                contactNumber: hiker?.user?.contactNumber ?? "Unknown"
            )
            .presentationDetents([.fraction(0.3)])
        }
        .edgesIgnoringSafeArea(.bottom)
        
        
    }
}

//#Preview {
//    ActiveHikersDetailView()
//}
