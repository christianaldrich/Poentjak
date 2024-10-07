//
//  AttributesInfoModifier.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 02/10/24.
//

import SwiftUI

struct AttributesInfoModifier: ViewModifier{
    func body(content: Content) -> some View{
        
        content
            .font(.caption2)
            .fontWeight(.light)
            .foregroundStyle(.gray)
        
    }
}
