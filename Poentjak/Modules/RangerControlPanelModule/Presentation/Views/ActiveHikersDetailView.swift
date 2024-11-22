//
//  ActiveHikersDetailView.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 07/10/24.
//

import SwiftUI

struct ActiveHikersDetailView: View {
    let hiker: EmergencyRequestModel?
    @StateObject var viewModel : ActiveHikersViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var isContactActive = false
    
    @StateObject var authViewModel: AuthViewModel

    @State private var image: UIImage?

    
    
    var body: some View {
        
        VStack(spacing: 16){
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        
                        
                        if let image = image{
                            Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 95)
                            .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .foregroundColor(.gray)
                                .clipShape(Circle())
                        }
                        
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
        .onAppear{
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
//                authViewModel.retrievePhoto(userName: name)
            authViewModel.retrievePhotoRanger(userName: hiker?.user?.name ?? ""){image in
                if let image = image {
                    print("Successfully retrieved image for user TEST.")
                    // Update the UI with the image
                    DispatchQueue.main.async {
                        self.image = image
                    }
                } else {
                    print("Failed to retrieve image for user TEST.")
                }
                
            }
//            }
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
