//
//  WiseGuideDataContent.swift
//  Poentjak
//
//  Created by Felicia Himawan on 20/11/24.
//

import Foundation

struct WiseGuideDataContent: Identifiable{
    var id = UUID()
    var image: String?
    var title: String
    var desc: String
    
    
    init(image: String? = nil, title: String, desc: String) {
        self.image = image
        self.title = title
        self.desc = desc
    }
    
}
