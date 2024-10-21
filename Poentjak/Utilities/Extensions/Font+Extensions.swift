//
//  Font+Extensions.swift
//  Poentjak
//
//  Created by Singgih Tulus Makmud on 14/10/24.
//

import SwiftUI

extension Font {
    static var largeTitleRegular: Font = {
        return Font.system(size: 34, weight: .regular)
    }()
    
    static var largeTitleEmphasized: Font = {
        return Font.system(size: 34, weight: .bold)
    }()
    
    static var title1Regular: Font = {
        return Font.system(size: 28, weight: .regular)
    }()
    
    static var title1Emphasized: Font = {
        return Font.system(size: 28, weight: .bold)
    }()
    
    static var title2Regular: Font = {
        return Font.system(size: 22, weight: .regular)
    }()
    
    static var title2Emphasized: Font = {
        return Font.system(size: 22, weight: .bold)
    }()
    
    static var title3Regular: Font = {
        return Font.system(size: 20, weight: .regular)
    }()
    
    static var title3Emphasized: Font = {
        return Font.system(size: 20, weight: .bold)
    }()
    
    static var headlineRegular: Font = {
        return Font.system(size: 17, weight: .semibold)
    }()
    
    static var headlineItalic: Font = {
        return Font.system(size: 17, weight: .semibold).italic()
    }()
    
    static var bodyRegular: Font = {
        return Font.system(size: 17, weight: .regular)
    }()
    
    static var bodyEmphasized: Font = {
        return Font.system(size: 17, weight: .semibold)
    }()
    
    static var bodyItalic: Font = {
        return Font.system(size: 17, weight: .regular).italic()
    }()
    
    static var bodyEmphasizedItalic: Font = {
        return Font.system(size: 17, weight: .semibold).italic()
    }()
    
    static var calloutRegular: Font = {
        return Font.system(size: 16, weight: .regular)
    }()
    
    static var calloutEmphasized: Font = {
        return Font.system(size: 16, weight: .semibold)
    }()
    
    static var calloutItalic: Font = {
        return Font.system(size: 16, weight: .regular).italic()
    }()
    
    static var calloutEmphasizedItalic: Font = {
        return Font.system(size: 16, weight: .semibold).italic()
    }()
    
    static var subheadlineRegular: Font = {
        return Font.system(size: 15, weight: .regular)
    }()
    
    static var subheadlineEmphasized: Font = {
        return Font.system(size: 15, weight: .semibold)
    }()
    
    static var subheadlineItalic: Font = {
        return Font.system(size: 15, weight: .regular).italic()
    }()
    
    static var subheadlineEmphasizedItalic: Font = {
        return Font.system(size: 15, weight: .semibold).italic()
    }()
    
    static var footnoteRegular: Font = {
        return Font.system(size: 13, weight: .regular)
    }()
    
    static var footnoteEmphasized: Font = {
        return Font.system(size: 13, weight: .semibold)
    }()
    
    static var footnoteEmphasizedBold: Font = {
        return Font.system(size: 13, weight: .bold)
    }()
    
    static var footnoteItalic: Font = {
        return Font.system(size: 13, weight: .regular).italic()
    }()
    
    static var footnoteEmphasizedItalic: Font = {
        return Font.system(size: 13, weight: .semibold).italic()
    }()
    
    static var caption1Regular: Font = {
        return Font.system(size: 12, weight: .regular)
    }()
    
    static var caption1Emphasized: Font = {
        return Font.system(size: 12, weight: .medium)
    }()
    
    static var caption1Italic: Font = {
        return Font.system(size: 12, weight: .regular).italic()
    }()
    
    static var caption1EmphasizedItalic: Font = {
        return Font.system(size: 12, weight: .medium).italic()
    }()
    
    static var caption2Regular: Font = {
        return Font.system(size: 11, weight: .regular)
    }()
    
    static var caption2Emphasized: Font = {
        return Font.system(size: 11, weight: .semibold)
    }()
    
    static var caption2Italic: Font = {
        return Font.system(size: 11, weight: .regular).italic()
    }()
    
    static var caption2EmphasizedItalic: Font = {
        return Font.system(size: 11, weight: .semibold).italic()
    }()
    
    static var labelCaption1Emphasized: Font = {
        return Font.system(size: 8, weight: .bold)
    }()

    //custom
    static var customLabelRescueStatus: Font = {
        return Font.system(size: 10, weight: .bold)
    }()
    
    static var customTabTitle: Font = {
        return Font.system(size: 10, weight: .medium)
    }()
    
    static var customLabelHourLeft: Font = {
        return Font.system(size: 13, weight: .bold)
    }()
    
    static var customLabelEmergencyStatus: Font = {
        return Font.system(size: 13, weight: .bold)
    }()
    
    static var customPrimaryButton: Font = {
        return Font.system(size: 16, weight: .bold)
    }()
    
    static var customTabSymbol: Font = {
        return Font.system(size: 18, weight: .medium)
    }()
    
}

