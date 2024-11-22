//
//  WiseGuideDetailView.swift
//  Poentjak
//
//  Created by Felicia Himawan on 20/11/24.
//
import SwiftUI

struct WiseGuideDetailView: View {
    var data: WiseGuideDataModel
    @State private var scrollOffset: CGFloat = 0
    @State private var totalContentHeight: CGFloat = 1
    
    var body: some View {
        ZStack {
            ScrollView {
                ZStack(alignment: .top) {
                    Image("WiseGuide/detailBackground")
                    
                    VStack {
                        Image(data.sqaureImage)
                        
                        Text(data.title)
                            .font(.bodyEmphasized)
                            .padding(.vertical, 16)
                        
                        Rectangle()
                            .fill(Color.neutralGrayCoolGray)
                            .frame(height: 0.76)
                            .padding(.bottom, 24)
                            .padding(.top, 16)
                            .padding(.horizontal, 46)
                        
                        ForEach(data.content) { content in
                            CustomCardGuideDetail(data: content)
                                .padding(.bottom, 24)
                        }
                        
                        Text("Source: \(data.source)")
                            .font(.footnoteRegular)
                            .foregroundColor(Color.primaryGreen500)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                    .padding(.top, 28)
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    totalContentHeight = geometry.size.height
                                }
                        }
                    )
                }
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onChange(of: proxy.frame(in: .global).minY) { value in
                                scrollOffset = -value
                            }
                    }
                )
            }
            .scrollIndicators(.hidden)

            VStack {
                Spacer()
                ZStack(alignment: .bottom) {
                    Color.white
                        .frame(maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.bottom)
                    
                    ProgressView(value: scrollProgress)
                        .progressViewStyle(LinearProgressViewStyle(tint: .primaryGreen500))
                        .padding(.horizontal, 25)
                }
                .frame(maxWidth: .infinity, maxHeight: 8)
            }
            
           
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                BackButtonComponent{
                    
                }
            }
        }
    }
    
   
    
    // Calculate scroll progress
    private var scrollProgress: Double {
        guard totalContentHeight > 0 else { return 0 }
        return Double(min(max(scrollOffset / (totalContentHeight - UIScreen.main.bounds.height), 0), 1))
    }
}

#Preview {
    WiseGuideDetailView(data: WiseGuideData.defaultData)
}
