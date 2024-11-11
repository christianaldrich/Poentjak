//
//  String+Extensions.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 10/11/24.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
}
