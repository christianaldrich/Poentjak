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
    private let rangerUseCase: RangerUseCaseProtocol

    init(startRescueUseCase: StartRescueUseCaseProtocol, rangerUseCase: RangerUseCaseProtocol) {
        self.startRescueUseCase = startRescueUseCase
        self.rangerUseCase = rangerUseCase
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

    func addNewRanger(name: String) async {
        guard let emergencyRequest = emergencyRequest else { return }

        let newRanger = Ranger(id: "", name: name, available: true, trackId: emergencyRequest.user.trackId)

        do {
            let addedRanger = try await rangerUseCase.addRanger(newRanger)
            DispatchQueue.main.async {
                self.availableRangers.append(addedRanger)
            }
        } catch {
            print("Failed to add new ranger: \(error.localizedDescription)")
        }
    }

    func editRanger(_ ranger: Ranger) async {
        do {
            let updatedRanger = try await rangerUseCase.editRanger(ranger)
            DispatchQueue.main.async {
                if let index = self.availableRangers.firstIndex(where: { $0.id == ranger.id }) {
                    self.availableRangers[index] = updatedRanger
                }
            }
        } catch {
            print("Failed to edit ranger: \(error.localizedDescription)")
        }
    }

    func deleteRanger(_ ranger: Ranger) async {
        do {
            try await rangerUseCase.deleteRanger(ranger)
            DispatchQueue.main.async {
                self.availableRangers.removeAll { $0.id == ranger.id }
            }
        } catch {
            print("Failed to delete ranger: \(error.localizedDescription)")
        }
    }
}
