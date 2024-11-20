//
//  WiseGuideData.swift
//  Poentjak
//
//  Created by Felicia Himawan on 20/11/24.
//

import Foundation

struct WiseGuideData {
    static var defaultData = WiseGuideDataModel(
        thumbnailImage: "dummy",
        sqaureImage: "dummy",
        title: "This is dummy data",
        content:
                [WiseGuideDataContent(
                    title: "dummy title 1",
                    desc: "dummyyyydummyyyyydummyyyyydummyyyyydummyyyyydummyyyyydummyyyyydummyyyyydummyyyyydummyyyyyy"
                ),
                 WiseGuideDataContent(
                    image: "dummy",
                    title: "dummy title 2",
                    desc: "dummyyyyydummyyyyydummyyyyydummyyyyydummyyyyy"
                 )
                ]
    )
    
    static var data: [String: WiseGuideDataModel] = [
        "lost": WiseGuideDataModel(
            thumbnailImage: "WiseGuide/wiseGuide1",
            sqaureImage: "WiseGuide/wiseGuide1",
            title: "This road seems off to me, I think I’m lost",
            content:
                [WiseGuideDataContent(
                    title: "Stay close to your friends",
                    desc: "Many people are lost when they are left by their friends. To prevent that, always stick close to your friends no matter what."
                ),
                 WiseGuideDataContent(
                    image: "dummy",
                    title: "Stop!",
                    desc: "Take a deep breath and pause for a moment. Rushing won’t help, so stay calm."
                 )]
        ),
        "hipo": WiseGuideDataModel(
            thumbnailImage: "WiseGuide/wiseGuide2",
            sqaureImage: "WiseGuide/wiseGuide2",
            title: "I feel cold, is it hypothermia?",
            content:
                [WiseGuideDataContent(
                    title: "What is hypothermia?",
                    desc: "Hypothermia is a dangerous drop in body temperature below 35C\n*normal body temperature is around 37C"
                )]
        )
    ]
}

