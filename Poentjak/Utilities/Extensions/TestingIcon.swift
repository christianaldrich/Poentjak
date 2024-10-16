//
//  TestingIcon.swift
//  Poentjak
//
//  Created by Felicia Himawan on 15/10/24.
//

import SwiftUI

struct TestingIcon: View {
    var body: some View {
        VStack{
            Text("ini testing buat icons")
            
            HStack{
                Image.AdminIcon.call
                Image.AdminIcon.checkboxChecked
                Image.AdminIcon.checkboxUnchecked
                Image.AdminIcon.filter
                Image.AdminIcon.history
            }
            
            HStack{
                Image.AlertIcon.success
                
            }
            
            HStack{
                Image.ButtonIcon.close
                Image.ButtonIcon.edit
                Image.ButtonIcon.guide
                Image.ButtonIcon.profile
            }
            
            HStack{
                Image.ExploreIcon.mountainBig
                Image.ExploreIcon.mountainSmall
                Image.ExploreIcon.track
            }
            
            
            HStack{
                Image.GenderIcon.female
                Image.GenderIcon.male
                Image.GenderIcon.others
            }
            
            
            
            HStack{
                Image.GuideIcon.guideChecked
                Image.GuideIcon.guideUnchecked
            }
            
            
            
            HStack{
                Image.HikerDetailIcon.note
                
            }
            
            
            HStack{
                Image.LabelIcon.add
                Image.LabelIcon.age
                Image.LabelIcon.clock
                Image.LabelIcon.height
                Image.LabelIcon.weight
            }
            
            HStack{
                Image.LabelIcon.hypothermia
                    .renderingMode(.template)
                    .foregroundStyle(Color.neutralGrayCoolGray)
                Image.LabelIcon.injured
                    .renderingMode(.template)
                    .foregroundStyle(Color.accentRedSos)
                Image.LabelIcon.lost
                    .renderingMode(.template)
                    .foregroundStyle(Color.secondaryYellow500)
            }
            
            HStack{
                Image.LabelIcon.postBig
                Image.LabelIcon.postSmall
                Image.LabelIcon.tap
            }
            
            
            
            HStack{
                Image.PickerIcon.search
            }
            
            
            
            HStack{
                Image.SoundBoardIcon.airhorn
                Image.SoundBoardIcon.alarm
                Image.SoundBoardIcon.sosMorse
                Image.SoundBoardIcon.whistle
            }
            
            
            
            HStack{
                Image.TextFieldIcon.eyeHide
                Image.TextFieldIcon.eyeUnhide
            }   
            
        }
    }
}

#Preview {
    TestingIcon()
}
