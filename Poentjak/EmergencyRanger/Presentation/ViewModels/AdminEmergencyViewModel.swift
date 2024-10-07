//
//  AdminViewModel.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 02/10/24.
//

import Foundation

@MainActor
class AdminEmergencyViewModel: ObservableObject {
    @Published var emergencyRequest: EmergencyRequest?
    @Published var availableRangers: [Ranger] = []
    @Published var selectedRangerIds: [String] = []
    
    private let startRescueUseCase: StartRescueUseCaseProtocol
    private let addRangerUseCase: AddRangerUseCaseProtocol

    init(startRescueUseCase: StartRescueUseCaseProtocol, addRangerUseCase: AddRangerUseCaseProtocol) {
        self.startRescueUseCase = startRescueUseCase
        self.addRangerUseCase = addRangerUseCase
    }

    func loadEmergencyData(emergencyRequestId: String) async {
        do {
            let (request, rangers) = try await startRescueUseCase.fetchEmergencyRequest(emergencyRequest: emergencyRequestId)
            DispatchQueue.main.async {
                self.emergencyRequest = request
                self.availableRangers = rangers
            }
        } catch {
            print("Failed to load data: \(String(describing: error))")
        }
    }

    func assignRangers(rangerIds: [String]) async {
        guard let emergencyRequest = emergencyRequest else { return }
        do {
            try await startRescueUseCase.assignRangersToEmergency(emergencyRequest: emergencyRequest.id, rangerIds: rangerIds)
            await loadEmergencyData(emergencyRequestId: emergencyRequest.id)
            
            selectedRangerIds.removeAll()
        } catch {
            print("Failed to assign rangers: \(error.localizedDescription)")
        }
    }

    func addNewRanger(name: String, trackId: String) async {
        let newRanger = Ranger(id: UUID().uuidString, name: name, available: true, trackId: trackId)
        do {
            let addedRanger = try await addRangerUseCase.execute(newRanger)
            DispatchQueue.main.async {
                self.availableRangers.append(addedRanger)
            }
        } catch {
            print("Failed to add new ranger: \(error.localizedDescription)")
        }
    }
}
