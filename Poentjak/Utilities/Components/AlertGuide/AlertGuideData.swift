//
//  AlertGuideData.swift
//  Poentjak
//
//  Created by Felicia Himawan on 22/10/24.
//

import Foundation

struct AlertGuideData{
    static var defaultData = AlertGuideContentDataModel(image: "dummy", title: "Dummy", content: "Dummy")
    
    static var data: [String: [Int: AlertGuideContentDataModel]] = [
        "STOP": [
            1: AlertGuideContentDataModel(image: "dummy", title: "Stop", content: "stop stop stop please please please dont prove em right"),
            2: AlertGuideContentDataModel(image: "dummy", title: "Terima kasih", content: "but please please please dont bring me to tears when i just did my make up so nice"),
            3: AlertGuideContentDataModel(image: "dummy", title: "Oooo begitu", content: "stop stop stop please please please dont prove em right"),
            4: AlertGuideContentDataModel(image: "dummy", title: "Payah si feli noob", content: "but please please please dont bring me to tears when i just did my make up so nice")
        ],
        
        "CARE": [
            1: AlertGuideContentDataModel(image: "dummy", title: "Caaree", content: "stop stop stop please please please dont prove em right"),
            2: AlertGuideContentDataModel(image: "dummy", title: "Anjay", content: "but please please please dont bring me to tears when i just did my make up so nice"),
            3: AlertGuideContentDataModel(image: "dummy", title: "Rererere", content: "stop stop stop please please please dont prove em right"),
            4: AlertGuideContentDataModel(image: "dummy", title: "Eek", content: "but please please please dont bring me to tears when i just did my make up so nice")
        ]
    ]

}
