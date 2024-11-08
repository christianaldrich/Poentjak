//
//  AlertGuideContent.swift
//  Poentjak
//
//  Created by Felicia Himawan on 22/10/24.
//

import SwiftUI

struct AlertGuideContent: View {
    var contentData: AlertGuideContentDataModel
    @State private var currentIndex = 0
    
    var body: some View {
        VStack (alignment: .leading){
            if let images = contentData.images, images.count > 1 {
                // Display carousel for multiple images
                ZStack {
                    TabView(selection: $currentIndex) {
                        ForEach(images.indices, id: \.self) { index in
                            Image(images[index])
                                .resizable()
                                .frame(width: 340, height: 320)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                    .frame(width: 340, height: 320)
                    
                    indicatorOverlay(images: images)
                    
                    speechButtonOverlay
                    
                    chevronButtons
                    
                }
                .frame(width: 340, height: 320)
                
                
            } else if let image = contentData.images?.first {
                // Display single image
                ZStack(alignment: .bottomLeading) {
                    Image(image)
                        .resizable()
                        .frame(width: 340, height: 320)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    speechButton
                        .padding([.leading, .bottom], 16)
                }
            }
            
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

// MARK: - Extension View
extension AlertGuideContent{
    var speechButton: some View {
        Button(action: {
            //                ttsViewModel.toggleSpeech(title: contentData.title, content: contentData.content)
        }) {
            Image.ButtonIcon.sound
                .padding(4)
                .background(Color.white)
                .clipShape(Circle())
        }
    }
    
    var chevronLeft: some View {
        Button(action: {
            if currentIndex > 0 {
                currentIndex -= 1
            }
        }) {
            Image(systemName: "chevron.left")
                .font(.customPrimaryButton)
                .foregroundColor(.primaryGreen500)
                .padding(8)
                .background(Color.white)
                .clipShape(Circle())
        }
        .opacity(currentIndex == 0 ? 0 : 1)
        .disabled(currentIndex == 0)
    }
    
    var chevronRight: some View {
        Button(action: {
            if currentIndex < (contentData.images?.count ?? 0) - 1 {
                currentIndex += 1
            }
        }) {
            Image(systemName: "chevron.right")
                .font(.customPrimaryButton)
                .foregroundColor(.primaryGreen500)
                .padding(8)
                .background(Color.white)
                .clipShape(Circle())
        }
        .opacity(currentIndex == (contentData.images?.count ?? 1) - 1 ? 0 : 1)
        .disabled(currentIndex == (contentData.images?.count ?? 1) - 1)
    }
    
    func indicatorOverlay(images: [String]) -> some View {
        VStack {
            Spacer()
            HStack(spacing: 8) {
                ForEach(images.indices, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.white : Color.primaryDisabledGreen)
                        .frame(width: 13)
                }
            }
            .padding(.bottom, 24)
        }
    }
    
    var chevronButtons: some View {
        HStack {
            chevronLeft
            Spacer()
            chevronRight
        }
        .padding(.horizontal, 16)
    }
    
    var speechButtonOverlay: some View {
        VStack {
            Spacer()
            HStack {
                speechButton
                Spacer()
            }
            .padding([.leading, .bottom], 16)
        }
    }
    
}

#Preview {
    var contentData = AlertGuideContentDataModel(image: "AlertGuideData/lostAlertGuide1", title: "Title", content: "Content")
    
    var testContentData = AlertGuideContentDataModel(images: ["AlertGuideData/lostAlertGuide1", "AlertGuideData/lostAlertGuide2", "AlertGuideData/lostAlertGuide3"], title: "test title", content: "dummy title")
    
    AlertGuideContent(contentData: contentData)
}
