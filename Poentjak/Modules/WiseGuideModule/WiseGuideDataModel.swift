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
    var source: String
    
    init(thumbnailImage: String, sqaureImage: String, title: String, content: [WiseGuideDataContent], source: String) {
        self.thumbnailImage = thumbnailImage
        self.sqaureImage = sqaureImage
        self.title = title
        self.content = content
        self.source = source
    }
}
