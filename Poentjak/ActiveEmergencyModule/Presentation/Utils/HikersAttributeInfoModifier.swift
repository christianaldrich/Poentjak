//
//  HikersAttributeInfoModifier.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 02/10/24.
//

import SwiftUI

struct HikersAttributeInfoModifier: ViewModifier{
    func body(content: Content) -> some View{
        
        content
            .font(.callout)
            .fontWeight(.heavy)
            .foregroundStyle(Color(red:27/255.0, green: 60/255.0, blue: 40/255.0))
        
    }
}
