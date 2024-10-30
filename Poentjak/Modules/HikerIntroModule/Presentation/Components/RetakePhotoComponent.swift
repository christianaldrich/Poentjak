//
//  RetakePhotoComponent.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 29/10/24.
//

import SwiftUI

struct RetakePhotoComponent: View {
    var action : () -> Void
    var body: some View {
//        Text()
        Button{
            action()
        }label: {
            Image.ButtonIcon.editBig
        }
    }
}

#Preview {
    RetakePhotoComponent(action: {print("asdfasdf")})
}
