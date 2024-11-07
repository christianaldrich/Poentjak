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
            1: AlertGuideContentDataModel(image: "AlertGuideData/lostAlertGuide1", title: "Stop!", content: "Take a deep breath and pause for a moment. Rushing won’t help, so stay calm."),
            2: AlertGuideContentDataModel(image: "AlertGuideData/lostAlertGuide2", title: "Think", content: "Give yourself a second to think things through. A clear mind leads to better choices!"),
            3: AlertGuideContentDataModel(image: "AlertGuideData/lostAlertGuide3", title: "Observe", content: "Look around and check your surroundings. Where are you? What's nearby? Do you recognize any rocks or trees that you’ve past through?"),
            4: AlertGuideContentDataModel(image: "AlertGuideData/lostAlertGuide4", title: "Plan", content: "If you can’t identify your surroundings, stay where you are and try to send an SOS signal. If you do not have signal, try to head to your nearest last seen location if possible.")
        ],
        
        "WARM": [
            1: AlertGuideContentDataModel(image: "AlertGuideData/hipoAlertGuide1", title: "Wrap up", content: "Bundle the person in anything warm and dry. Blankets, jackets, an emergency blanket, even extra clothes. Keep that body heat in!"),
            2: AlertGuideContentDataModel(image: "AlertGuideData/hipoAlertGuide2", title: "Assess", content: "Take a quick look at how they’re doing, are they shivering, confused, or really cold? Check their condition."),
            3: AlertGuideContentDataModel(image: "dummy", title: "Raise Heat", content: "Slowly warm them up with your body heat, warm drinks (if they’re awake), or heat packs, just go gentle, no sudden heat!"),
            4: AlertGuideContentDataModel(image: "dummy", title: "Move to Safety", content: "Get them to a warm, safe spot as soon as you can to keep them protected from the cold. If symptoms get worse, alert our rangers!")
        ],
        
        "CARE": [
            1: AlertGuideContentDataModel(image: "dummy", title: "Calm Down", content: "Stay calm, take deep breaths, and help the injured person relax. Panic won’t help, keeping a cool head will."),
            2: AlertGuideContentDataModel(image: "dummy", title: "Assess the Injury", content: "Check what’s wrong, is it a twisted ankle, a cut from the fall, or are they unable to move? Prioritize the most urgent issue (like bleeding)."),
            3: AlertGuideContentDataModel(images: ["dummy", "dummy", "dummy"], title: "Respond", content: "For a twisted ankle, stabilize it with a bandage or support. If they're bleeding, apply pressure to stop it. If they can't move, make sure they’re comfortable and avoid moving them further."),
            4: AlertGuideContentDataModel(image: "dummy", title: "Evaluate the Situation", content: "Decide if you can treat the injury on-site, if you need to call the rangers or get them to a safer location for medical attention.")
        ]
        
//        "CARE": [
//            1: AlertGuideContentDataModel(image: "dummy", title: "Caaree", content: "stop stop stop please please please dont prove em right"),
//            2: AlertGuideContentDataModel(image: "dummy", title: "Anjay", content: "but please please please dont bring me to tears when i just did my make up so nice"),
//            3: AlertGuideContentDataModel(image: "dummy", title: "Rererere", content: "stop stop stop please please please dont prove em right"),
//            4: AlertGuideContentDataModel(image: "dummy", title: "Eek", content: "but please please please dont bring me to tears when i just did my make up so nice")
//        ]
    ]

}
