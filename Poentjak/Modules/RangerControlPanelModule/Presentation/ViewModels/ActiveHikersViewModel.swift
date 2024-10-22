//
//  ActiveHikersViewModel.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 07/10/24.
//

import Foundation
import SwiftUI

class ActiveHikersViewModel: ObservableObject{
    @Published var activeHikers: [EmergencyRequestModel] = []
    
    private let activeHikersUseCase: ActiveHikersUseCaseProtocol
    
    init(activeHikersUseCase: ActiveHikersUseCaseProtocol) {
        self.activeHikersUseCase = activeHikersUseCase
        fetchActiveHikers()
    }
    
    func fetchActiveHikers() {
        activeHikersUseCase.fetchActiveHikers { [weak self] requests in
            DispatchQueue.main.async {
                self?.activeHikers = requests
                //                        print("Updated active hikers: \(requests)")
            }
        }
    }
    
    func countDue(input: Date) -> CustomLabelStatus {
        let currentDate = Date()
        print("Current Date: \(currentDate)")
        print("Input: \(input)")
        
        if currentDate < input {
            let hoursRemaining = Calendar.current.dateComponents([.hour], from: currentDate, to: input).hour ?? 0
            print("\n\n\n\nTSETSETST\(hoursRemaining)")
            //            return hoursRemaining
            
            if hoursRemaining <= 1{
                print("sisa 1 jam")
                return CustomLabelStatus(type: .redHours(remainingTime: "<= 1 HR"))
            }
            else if hoursRemaining <= 3{
                print("sisa 3 jam ")
                return CustomLabelStatus(type: .yellowHours(remainingTime: "\(hoursRemaining) HRS"))
            }
            else{
                print("masih lama")
                return CustomLabelStatus(type: .greenHours(remainingTime: "\(hoursRemaining) HRS"))
                
            }
            
        } else {
            return CustomLabelStatus(type: .redHours(remainingTime: "0 HR"))
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
    
    func updateHikerSession(userId: String) async {
        do {
            try await activeHikersUseCase.updateHikerSession(userId: userId)
        } catch {
            print("Failed in Active Hikers View Model")
        }
    }
    
    func dateFormatter(input: Date) -> String{
        let formattedDate = DateFormatter()
        formattedDate.dateFormat = "E, MMM d 'at' HH:mm"
        let dateString = formattedDate.string(from: input)
        
        return dateString
    }
    
    
    
}

//CustomLabelStatus(type: .inRescue)
//CustomLabelStatus(type: .arrived)
//CustomLabelStatus(type: .redHours(remainingTime: "1 HR"))
//CustomLabelStatus(type: .yellowHours(remainingTime: "3 HRS"))
//CustomLabelStatus(type: .greenHours(remainingTime: "7 HRS"))
//CustomLabelStatus(type: .iconOnly)
//CustomLabelStatus(type: .iconAndText)
