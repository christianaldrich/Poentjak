//
//  AlertGuideTestingView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 22/10/24.
//

import SwiftUI

struct AlertGuideTestingView: View {
    @StateObject var viewModel = AlertGuideTestingViewModel()
    var body: some View {
        VStack{
            AlertGuideTabBar(idSelected: $viewModel.idSelected, text: viewModel.text)
            AlertGuideContent(contentData: viewModel.contentData)
        }
        .padding()
        
    }
}

#Preview {
    AlertGuideTestingView()
}
