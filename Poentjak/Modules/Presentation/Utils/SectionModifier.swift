//
//  SectionModifier.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 02/10/24.
//

import SwiftUI

struct SectionModifier: ViewModifier{
    func body(content: Content) -> some View{
        
        content
            .font(.title2)
            .foregroundStyle(.black)
            .fontWeight(.bold)
            .textCase(nil)
        
    }
}
