//
//  WiseGuideDataModel.swift
//  Poentjak
//
//  Created by Felicia Himawan on 20/11/24.
//

import Foundation

struct WiseGuideDataModel{
    var thumbnailImage: String
    var sqaureImage: String
    var title: String
    var content: [WiseGuideDataContent]
    
    init(thumbnailImage: String, sqaureImage: String, title: String, content: [WiseGuideDataContent]) {
        self.thumbnailImage = thumbnailImage
        self.sqaureImage = sqaureImage
        self.title = title
        self.content = content
    }
}
