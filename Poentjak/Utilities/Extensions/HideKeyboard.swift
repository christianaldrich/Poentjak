//
//  HideKeyboard.swift
//  Poentjak
//
//  Created by Christian Aldrich Darrien on 21/11/24.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
