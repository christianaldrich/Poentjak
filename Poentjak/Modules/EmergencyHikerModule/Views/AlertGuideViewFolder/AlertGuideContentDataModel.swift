//
//  AlertGuideContentDataModel.swift
//  Poentjak
//
//  Created by Felicia Himawan on 22/10/24.
//

import Foundation

//struct AlertGuideContentDataModel{
//    let image: String
//    let title: String
//    let content: String
//}


struct AlertGuideContentDataModel {
    let images: [String]?
    let title: String
    let content: String
    
    init(image: String, title: String, content: String) {
        self.images = [image]
        self.title = title
        self.content = content
    }
    
    init(images: [String], title: String, content: String) {
        self.images = images
        self.title = title
        self.content = content
    }
}
