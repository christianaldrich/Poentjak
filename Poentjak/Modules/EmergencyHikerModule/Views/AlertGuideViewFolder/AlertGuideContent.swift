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
            if let images = contentData.images, images.count > 1 {
                // Display carousel for multiple images
                TabView {
                    ForEach(images, id: \.self) { image in
                        Image(image)
                            .resizable()
                            .frame(width: 340, height: 320)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(width: 340, height: 320)

            
            } else if let image = contentData.images?.first {
                // Display single image
                Image(image)
                    .resizable()
                    .frame(width: 340, height: 320)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
//                    .padding(.bottom, 10)
            }
            //            Image(contentData.image)
            //                .resizable()
            //                .frame(width: 340, height: 320)
            //                .clipShape(RoundedRectangle(cornerRadius: 16))
            //                .padding(.bottom, 10)
            
            Text(contentData.title)
                .font(.largeTitleEmphasized)
                .foregroundStyle(Color.errorRed500)
                .padding(.bottom, 8)
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(contentData.content)
                .font(.subheadlineRegular)
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(.horizontal, 25)
        
    }
}

#Preview {
    var contentData = AlertGuideContentDataModel(image: "dummy", title: "Title", content: "Content")
    AlertGuideContent(contentData: contentData)
}
