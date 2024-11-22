//
//  UserProfileView.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 21/10/24.
//

import Foundation
import SwiftUI

struct UserProfileView: View {
    let emergencyRequest: EmergencyRequest
    @StateObject var authViewModel: AuthViewModel
    @State private var image: UIImage?
    var body: some View {
        HStack {
            if let image = image{
                Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70,height: 95)
                .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75,height: 75)
                    .foregroundColor(.gray)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    switch emergencyRequest.emergencyType {
                    case .hipo:
                        CustomLabelEmergencyType(type: .hypothermia)
                    case .injury:
                        CustomLabelEmergencyType(type: .injury)
                    case .lost:
                        CustomLabelEmergencyType(type: .lost)
                    case .overdue:
                        CustomLabelEmergencyType(type: .overdue)
                    case .none:
                        CustomLabelEmergencyType(type: .overdue)
                    }
                    
                    Spacer()
                    Text(minutesAgo(from: emergencyRequest.dueDate))
                        .font(.caption1Regular)
                        .foregroundStyle(Color.neutralGrayTertiaryGray)
                }
                
                HStack {
                    Text(emergencyRequest.user.name)
                        .font(.headlineRegular)
                    switch emergencyRequest.user.gender{
                    case "male": //nanti ganti male
                        Image.GenderIcon.male
                    case "female": // nanti ganti female
                        Image.GenderIcon.female
                    default:
                        Image.GenderIcon.others
                    }
                    Spacer()
                }
            }
            .padding(.leading, 12)
        }
        .onAppear{
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
//                authViewModel.retrievePhoto(userName: name)
            authViewModel.retrievePhotoRanger(userName: emergencyRequest.user.name){image in
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
    }
}
