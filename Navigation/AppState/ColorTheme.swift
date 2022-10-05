//
//  ColorTheme.swift
//  Navigation
//
//  Created by Vadim on 05.10.2022.
//

import Foundation
import UIKit

struct Theme {
        
    enum ThemeType {
        case light
        case dark
    }
    let type: ThemeType
    let colors: ColorPalette
}

extension Theme {
    static let light = Theme(type: .light, colors: .light)
    static let dark = Theme(type: .dark, colors: .dark)
}

protocol Themeable: AnyObject {
    func apply(theme: Theme)
}
