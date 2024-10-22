//
//  AlertGuideTestingViewModel.swift
//  Poentjak
//
//  Created by Felicia Himawan on 22/10/24.
//

import Foundation

class AlertGuideTestingViewModel: ObservableObject {
    @Published var text = "CARE"
    @Published var idSelected: Int = 1 {
        didSet {
            getContentData()  // Call getContentData whenever idSelected changes
        }
    }
    @Published var contentData: AlertGuideContentDataModel = AlertGuideData.defaultData

    init() {
        getContentData()  // Initial load of content data
    }
    
    func getContentData() {
        self.contentData = AlertGuideData.data[text]?[idSelected] ?? AlertGuideData.defaultData
    }
}
