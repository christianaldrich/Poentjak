//
//  EmergencyCardComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 20/10/24.
//

import SwiftUI
import PhotosUI

struct EmergencyCardComponent: View {
    
    @State var name: String = ""
    @State var gender: String = ""
    @State var type: String = ""
    @State var age: Int = 0
    @State var weight: Int = 0
    @State var height: Int = 0
    @State var status: String = ""
    @State var dueDate: Date
    @StateObject var authViewModel: AuthViewModel
    @State var image: UIImage?
    
    @State private var isProfileFetched = true
    
    

    
    var body: some View {
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .frame(width: 343, height: 114)
            
            HStack{
                
                
                if let image = image{
                    Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 83, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .customShadow()
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 83, height: 80)
                        .foregroundColor(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .customShadow()
                }
      
                
                VStack(alignment: .leading, spacing: 2){
                    HStack{
                        customLabel(type)
                            
                        
                        Spacer()
                        
                        Text(minutesAgo(from: dueDate))
                            .font(.caption1Regular)
                    }
                    Text("\(name)")
                        .font(.headlineRegular)
                    
                    HStack{
                        HStack(spacing: 2){
                            customGender(gender)
                            Text("\(age) yrs")
                            Text("∙")
                            Text("\(weight) kg")
                            Text("∙")
                            Text("\(height) cm")
                        }
                        
                        .font(.caption1Regular)
                        
                        Spacer()
                        
                        customStatus(status)
                        
                    }
                    
                }
                
                .frame(width: 218)
                
                
                
            }
            
            .padding()
            
        }
        .onAppear{
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
//            if isProfileFetched == true{
//                authViewModel.retrievePhoto(userName: name)
//            }
//            isProfileFetched = false
            authViewModel.retrievePhotoRanger(userName: name){ image in
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
    
    func customLabel(_ type: String) -> CustomLabelEmergencyType {
        switch type.lowercased() {
        case "hipo":
            return CustomLabelEmergencyType(type: .hypothermia)
        case "injury":
            return CustomLabelEmergencyType(type: .injury)
        case "lost":
            return CustomLabelEmergencyType(type: .lost)
        default:
            return CustomLabelEmergencyType(type: .overdue)
        }
    }
    
    func customStatus(_ status: String) -> CustomLabelRescueStatus {
        switch status.lowercased() {
        case "completed":
            return CustomLabelRescueStatus(status: .complete)
        case "ongoing":
            return CustomLabelRescueStatus(status: .ongoing)
        default:
            return CustomLabelRescueStatus(status: .new)
        }
    }
    
    func customGender(_ gender: String) -> Image{
        switch gender.lowercased() {
        case "male":
            return Image.GenderIcon.male
        case "female":
            return Image.GenderIcon.female
        default:
            return Image.GenderIcon.others
        }
    }
}

//#Preview {
//    EmergencyCardComponent(name: "Joko Wijaya",gender: "male", type: "injury", age: 10, weight: 100, height: 180, status: "ongoing")
//}
