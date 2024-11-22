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
        sqaureImage: "WiseGuide/wiseGuideLost/squareImage1",
        title: "This is dummy data",
        content:
                [WiseGuideDataContent(
                    image: "WiseGuide/wiseGuideHipo/hipoContentImage1",
                    title: "dummy title 1",
                    desc: "Hand warmers provide quick warmth for your hands. Simply open the package, shake to start the heating process and put it in your gloves or pockets."
                ),
                 WiseGuideDataContent(
                    image: "dummy",
                    title: "dummy title 2",
                    desc: "dummyyyyydummyyyyydummyyyyydummyyyyydummyyyyy"
                 )
                ],
        source: "dummy source"
    )
    
    static var data: [String: WiseGuideDataModel] = [
        "lost": WiseGuideDataModel(
            thumbnailImage: "WiseGuide/wiseGuideLost/wiseGuide1",
            sqaureImage: "WiseGuide/wiseGuideLost/squareImage1",
            title: "This road seems off to me, I think I’m lost",
            content:
                [WiseGuideDataContent(
                    title: "Stay close to your friends",
                    desc: "Many people are lost when they are left by their friends. To prevent that, always stick close to your friends no matter what."
                ),
                 WiseGuideDataContent(
                    image: "WiseGuide/wiseGuideLost/lostContentImage1",
                    title: "Stop!",
                    desc: "Take a deep breath and pause for a moment. Rushing won’t help, so stay calm."
                 ),
                 WiseGuideDataContent(
                    image: "WiseGuide/wiseGuideLost/lostContentImage2",
                    title: "Think",
                    desc: "Give yourself a second to think things through. A clear mind leads to better choices!"
                 ),
                 WiseGuideDataContent(
                    image: "WiseGuide/wiseGuideLost/lostContentImage3",
                    title: "Observe",
                    desc: "Look around and check your surroundings. Where are you? What's nearby? Do you recognize any rocks or trees that you’ve past through?"
                 ),
                 WiseGuideDataContent(
                    image: "WiseGuide/wiseGuideLost/lostContentImage4",
                    title: "Plan",
                    desc: "If you can’t identify your surroundings, stay where you are and try to send an SOS signal. If you do not have signal, try to head to your nearest last seen location or evacuation point if possible."
                 )]
            , source: "Forest Service U.S. Department of Agriculture"
        ),
        "hipo": WiseGuideDataModel(
            thumbnailImage: "WiseGuide/wiseGuideHipo/wiseGuide2",
            sqaureImage: "WiseGuide/wiseGuideHipo/squareImage2",
            title: "I feel cold, is it hypothermia?",
            content:
                [WiseGuideDataContent(
                    title: "What is hypothermia?",
                    desc: "Hypothermia is a dangerous drop in body temperature below 35C\n*normal body temperature is around 37C"
                ),
                 WiseGuideDataContent(
                     title: "Causes",
                     desc: "• Did not wear enough clothes in cold weather\n• Have wet clothes and get cold\n• High altitude and wind exposure"
                 ),
                 WiseGuideDataContent(
                     title: "Symptoms",
                     desc: "• Shivering\n• Pale, cold and dry skin – skin and lips may turn blue or grey (on black or brown skin this may be easier to see on the palms of the hands or the soles of the feet)\n• Slurred speech\n• Slow breathing\n• Tiredness or confusion"
                 ),
                 WiseGuideDataContent(
                     title: "How to prevent?",
                     desc: "• Consume good and correct food (**5000** calories)\n• Food digestion produces body heat\n• Make sure your clothes are not wet"
                 ),
                 WiseGuideDataContent(
                     title: "Remember",
                     desc: "All parts of your body exposed to cold environment loses heat. So make sure to cover up with layers."
                 ),
                 WiseGuideDataContent(
                    image: "WiseGuide/wiseGuideHipo/hipoContentImage1",
                     title: "The must-bring blanket",
                     desc: "Bring an emergency blanket. It is lightweight, compact, and keeps you warm by trapping body heat and reflecting your body heat back to you."
                 ),
                 WiseGuideDataContent(
                    image: "WiseGuide/wiseGuideHipo/hipoContentImage2",
                    title: "The must-bring heat source",
                    desc: "Hand warmers provide quick warmth for your hands. Simply open the package, shake to start the heating process and put it in your gloves or pockets."
                 ),
                 WiseGuideDataContent(
                    title: "Don’t",
                    desc: "• Do not warm up with hot water bottle, heat lamp, hot bath\n• Do not rub their arms, legs, feet or hands\n• Do not give alcohol to drink\n• Do not leave them alone"
                 ),
                 WiseGuideDataContent(
                    title: "Do",
                    desc: "• Move the person indoors or to a sheltered spot quickly\n• Take off any wet clothes and wrap them in a dry blanket, sleeping bag, or towel covering their head\n• If they’re fully awake, give them a warm drink and some sugary food\n• Keep talking to them and help them stay awake until help arrives"
                 ),
                 WiseGuideDataContent(
                    title: "5 stages of hypothermia",
                    desc: "• Mild hypothermia (32-35C): Shivering, conscious\n• Moderate hypothermia (28-32C): Stop shivering, conscious impaired\n• Severe hypothermia (24-28C): Unconscious, difficult to detect vital signs\n• Apparent death (15-24C)"
                 ),
                 WiseGuideDataContent(
                    image: "WiseGuide/wiseGuideHipo/hipoContentImage3",
                    title: "Wrap up",
                    desc: "Remove wet clothing and bundle the person in anything warm and dry. Blankets, jackets, an emergency blanket, even extra clothes. Keep that body heat in!"
                 ),
                 WiseGuideDataContent(
                    image: "WiseGuide/wiseGuideHipo/hipoContentImage4",
                    title: "Assess",
                    desc: "Take a quick look at how they’re doing, are they shivering, confused, or really cold? Check their condition."
                 ),
                 WiseGuideDataContent(
                    image: "WiseGuide/wiseGuideHipo/hipoContentImage5",
                    title: "Raise Heat",
                    desc: "Slowly warm them up with your body heat, warm drinks (if they’re awake), or heat packs, just go gentle, no sudden heat!"
                 ),
                 WiseGuideDataContent(
                    image: "WiseGuide/wiseGuideHipo/hipoContentImage6",
                    title: "Safety",
                    desc: "Get them to a warm, safe spot as soon as you can to keep them protected from the cold. If symptoms get worse, alert our rangers!"
                 )
                ],
            source: "Source: National Health Service, Dwi Setiyani, M. ., & Fatwati Fitriana, N. . (2020). The relationship between knowledge and hypothermia first aid attitudes in mountain climbers. Proceedings Series on Health & Medical Sciences, 1, 108–113. https://doi.org/10.30595/pshms.v1i.46, Alpine Rescue, North Shore Rescue"
        ),
        "tips": WiseGuideDataModel(
            thumbnailImage: "WiseGuide/wiseGuideTips/wiseGuide3",
            sqaureImage: "WiseGuide/wiseGuideTips/squareImage3",
            title: "Survival tips",
            content:
                [WiseGuideDataContent(
                    title: "Remember, Rule of Threes",
                    desc: "• **3 seconds**: time to make a **decision**\n• **3 minutes**: brain’s limit **without oxygen**\n• **3 hours**: survival in **extreme weather** unprotected\n• **3 days**: survival **without water**\n• **3 weeks**: survival **without food**"
                ),
                 WiseGuideDataContent(
                     title: "Remember, S.U.R.V.I.V.A.L.",
                     desc: "If you face  a survival situation, this acronym could get you through."
                 ),
                 WiseGuideDataContent(
                     title: "Size up your situation",
                     desc: "• Check surroundings, condition, and resources\n• Share tasks in a group"
                 ),
                 WiseGuideDataContent(
                     title: "Use all your senses",
                     desc: "• Take note of sounds, smells, touch, taste.\n• Trust your instincts and gut feelings"
                 ),
                 WiseGuideDataContent(
                     title: "Remember where you are",
                     desc: "Understand where you are to make smart decisions"
                 ),
                 WiseGuideDataContent(
                     title: "Vanquish fear",
                     desc: "• Stop and calm yourself\n• Panic leads to poor judgement\n• Stay focused on what needs to be done"
                 ),
                 WiseGuideDataContent(
                     title: "Improvise",
                     desc: "Adapt and find creative solutions with what you have or what nature provides"
                 ),
                 WiseGuideDataContent(
                     title: "Value life",
                     desc: "• Think about happiness and your reason to live\n• Stay strong and never lose hope"
                 ),
                 WiseGuideDataContent(
                     title: "Act like the locals",
                     desc: "• Learn from local people and wildlife on how to adapt\n• Where are they eating, where they get water?"
                 ),
                 WiseGuideDataContent(
                     title: "Learn basic skills",
                     desc: "Training boosts survival chances, don’t rely on luck"
                 )
                ],
            source: "The Survival Skills, The Survival University"
        ),
        "animal": WiseGuideDataModel(
            thumbnailImage: "WiseGuide/wiseGuideAnimal/wiseGuide4",
            sqaureImage: "WiseGuide/wiseGuideAnimal/squareImage4",
            title: "Can a wild animal appear?",
            content:
                [WiseGuideDataContent(
                    title: "In general",
                    desc: "Animals usually stay away when humans are around, but it’s always good to stay alert and cautious."
                ),
                 WiseGuideDataContent(
                     title: "Stay aware",
                     desc: "• Watch for signs of animals, like tracks, droppings, or marks on trees from claws or antlers.\n•  It's best not to hike with headphones so you can hear what’s happening around you."
                 ),
                 WiseGuideDataContent(
                     title: "Dispose all waste properly",
                     desc: "If you don’t store or throw away food properly, it can bring wild animals to your campsite or resting spot."
                 ),
                 WiseGuideDataContent(
                     title: "Remain calm",
                     desc: "Unexpected movements can frighten and threaten animals, which might attack."
                 ),
                 WiseGuideDataContent(
                     title: "Never feed animals",
                     desc: "Feeding wild animals change their natural behavior, becoming more agressive"
                 ),
                 WiseGuideDataContent(
                     title: "Make noise",
                     desc: "Make noise while hiking to avoid surprising animals.Make noise while hiking to avoid surprising animals."
                 )
                ], source: "AdventureTipr"
        ),
        "camping": WiseGuideDataModel(
            thumbnailImage: "WiseGuide/wiseGuideCamping/wiseGuide5",
            sqaureImage: "WiseGuide/wiseGuideCamping/squareImage5",
            title: "Essential Camping Gears",
            content:
                [WiseGuideDataContent(
                    title: "Navigation",
                    desc: "Plan your route before hiking Tools: Map, compass, GPS system\n\n**Don’t worry, Hikewise provides real-time navigation with checkpoints with GPS.**"
                ),
                 WiseGuideDataContent(
                     title: "Sun protection",
                     desc: "Protect your skin and eyes against UV rays to prevent sunburns and skin cancer.\n\n**Use: Sunglasses, sunscreen, hats, sun protection clothing (pants, long sleeve shirts)**"
                 ),
                 WiseGuideDataContent(
                     title: "Insulation",
                     desc: "Always be prepared for unexpected weather conditions.\n\n**Clothing: Jacket, hat, gloves, rain coat**"
                 ),
                 WiseGuideDataContent(
                     title: "Illumination",
                     desc: "Lighting is essential where there are no regular light sources\n\n**Tools: Flashlight, headlamp, extra batteries**"
                 ),
                 WiseGuideDataContent(
                     title: "First-aid supplies",
                     desc: "Start with a pre-made kit and modify it according to your trip Remember to check the expiration date of all items\n\n**Tool: First aid kit**"
                 ),
                 WiseGuideDataContent(
                     title: "Repair kit and tools",
                     desc: "You might need to repair equipments during your trip. Consider preparing a multi-tool, compact version of several tools such as a Swiss knife.\n\n**Tools: Duct tape, knife, screwdriver, scissors**"
                 ),
                 WiseGuideDataContent(
                     title: "Nutrition",
                     desc: "Pack an extra day’s supply of food, preferably no-cook items with good nutrition to keep your energy high\n\n**Food: Salty and easy to digest snacks (granola bars, sausage, chocolate)**"
                 ),
                 WiseGuideDataContent(
                     title: "Hydration",
                     desc: "Make sure to drink water often before feeling thirsty because physical activity increases risk of dehydration\n\nBesides that, make sure to check whether there are any water bodies to collect water.\n\n**Water: Water and water treatment supplies**"
                 ),
                 WiseGuideDataContent(
                     title: "Emergency shelter",
                     desc: "Protect from severe weather conditions and place to sleep.\n\n**Tools: Tent, space blanket, sleeping bag**"
                 )
                ], source: "National Park Service"
        ),
        "injury": WiseGuideDataModel(
            thumbnailImage: "WiseGuide/wiseGuideInjury/wiseGuide6",
            sqaureImage: "WiseGuide/wiseGuideInjury/squareImage6",
            title: "What to do when your arm is injured",
            content:
                [WiseGuideDataContent(
                    title: "Immobilized arms",
                    desc: "• If you hurt your hand, arm, or shoulder, keep it still and raised.\n• If you don’t have a bandage, you can use a strong cloth, jacket, or backpack straps.\n• Ask another person to help tie up while holding your arm."
                ),
                 WiseGuideDataContent(
                    image: "WiseGuide/wiseGuideInjury/injuryContentImage1",
                     title: "Jacket corner",
                     desc: "To support an injured forearm or hand, fold the jacket up over the arm and pin it."
                 ),
                 WiseGuideDataContent(
                    image: "WiseGuide/wiseGuideInjury/injuryContentImage2",
                     title: "Button-up jacket",
                     desc: "Undo one of the buttons and slide the injured arm into the opening for support."
                 ),
                 WiseGuideDataContent(
                    image: "WiseGuide/wiseGuideInjury/injuryContentImage3",
                     title: "Shoulder strap",
                     desc: "Rest a sprain by tucking your hand in your backpack strap"
                 ),
                 WiseGuideDataContent(
                    image: "WiseGuide/wiseGuideInjury/injuryContentImage4",
                     title: "Pinned sleeve",
                     desc: "Pin your sleeve to the jacket or the strap of a backpack for support."
                 ),
                 WiseGuideDataContent(
                    image: "WiseGuide/wiseGuideInjury/injuryContentImage5",
                     title: "Belt support",
                     desc: "Support an upper arm injury in a raised position with a belt looped into a figure eight."
                 ),
                 WiseGuideDataContent(
                     title: "If you’re not feeling better",
                     desc: "Tap the SOS button and choose \"Injury.\" You can head to the nearest evacuation spot (warung) or notify the rangers for help."
                 )
                ], source: "The Survival Skills"
        )
        
        
    ]
}

