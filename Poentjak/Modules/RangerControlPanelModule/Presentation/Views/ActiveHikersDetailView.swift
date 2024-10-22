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


    
    var body: some View {
        VStack{
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
                    Text("Last seen 20 mins ago") // update nanti kasih logic lgi
                }
            }
            Text("Arrived by \(viewModel.dateFormatter(input: hiker?.dueDate ?? Date()))")
            
            Text("Insert label for Emergency Contact")
            
            HStack{
                CustomLabelGeneral(type: .hikerDetailData(type: .age(hiker?.user?.age ?? 0)))
                CustomLabelGeneral(type: .hikerDetailData(type: .weight(hiker?.user?.weight ?? 0)))
                CustomLabelGeneral(type: .hikerDetailData(type: .height(hiker?.user?.height ?? 0)))
            }
            
            Button("Back at basecamp"){
                Task{
                    await viewModel.updateHikerSession(userId: hiker?.user?.id ?? "")
                }
                dismiss()
            }
        }
    }
}

//#Preview {
//    ActiveHikersDetailView()
//}
