//
//  HikerRegisViewModel.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 29/10/24.
//

import Foundation
import PhotosUI

class HikerRegisViewModel: ObservableObject{
    
    @Published var fullName: String?
    @Published var gender: String?
    @Published var currentIndex: Int?
    @Published var capturedImage: UIImage?
    
    func updateCurrentIndex(currentIndex: Int){
        self.currentIndex = currentIndex
    }
    
    func storeCurrentNameGender(fullName: String, gender: String){
        
//        print("masuk")
        
        self.fullName = fullName
        self.gender = gender
//        self.currentIndex = currentIndex
        
//        print("\n\nFullname: \(fullName)\n")
//        print("Gender: \(gender)\n")
//        print("CurrentIndex: \(currentIndex)\n")
        
    }
    
    func storeCurrentProfilePicture(capturedImage: UIImage){
        self.capturedImage = capturedImage
        
//        print("\n\nFullname: \(String(describing: fullName))\n")
//        print("Gender: \(String(describing: gender))\n")
//        print("CurrentIndex: \(String(describing: currentIndex))\n")
//        print("capturedIMage: \(capturedImage)\n")
    }
    
    func uploadPhoto(){
        
    }
    
}
