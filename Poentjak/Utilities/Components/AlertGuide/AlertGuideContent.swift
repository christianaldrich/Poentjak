//
//  AlertGuideContent.swift
//  Poentjak
//
//  Created by Felicia Himawan on 22/10/24.
//

import SwiftUI

struct AlertGuideContent: View {
    var contentData: AlertGuideContentDataModel
    
    var body: some View {
        VStack (alignment: .leading){
            Image(contentData.image)
                .resizable()
                .frame(width: 340, height: 320)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.bottom, 10)
            
            Text(contentData.title)
                .font(.largeTitleEmphasized)
                .foregroundStyle(Color.errorRed500)
                .padding(.bottom, 8)
            
            Text(contentData.content)
                .font(.subheadlineRegular)
                .foregroundStyle(Color.black)

        }
        .padding(.horizontal, 25)
        
    }
}

#Preview {
    var contentData = AlertGuideContentDataModel(image: "dummy", title: "Title", content: "Content")
    AlertGuideContent(contentData: contentData)
}
