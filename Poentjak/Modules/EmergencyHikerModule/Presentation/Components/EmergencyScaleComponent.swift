//
//  EmergencyScaleComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 06/11/24.
//

import SwiftUI

struct EmergencyScaleComponent: View {
    
    
    
    @StateObject var viewModel: EmergencyProsesViewModel

    
    var body: some View {
        SliderComponent(sliderValue: $viewModel.emergencyScale)
//        Text("\(viewModel.emergencyScale)")
    }
}
//
//#Preview {
//    EmergencyScaleComponent()
//}
