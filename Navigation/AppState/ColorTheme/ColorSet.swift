//
//  ColorSet.swift
//  Navigation
//
//  Created by Vadim on 06.03.2022.
//

import UIKit

protocol Palettable {
    var foregroud: UIColor { get }
    var backgroud: UIColor { get }
    var cell: UIColor { get }
    var text: UIColor { get }
    var secondaryText: UIColor { get }
    var interactiveText: UIColor { get }
    var textfield: UIColor { get }
}

enum ColorPalette {
    
    case light
    case dark
    
    var palette: Palettable {
        switch self {
        case .light:
            return Light()
        case .dark:
            return Dark()
        }
    }
}

struct Light: Palettable {
    var foregroud = UIColor.rgb(255, 255, 255, 1)
    var backgroud = UIColor.rgb(235, 237, 240, 1)
    var cell = UIColor.rgb(255, 255, 255, 1)
    var text = UIColor.rgb(10, 10, 10, 1)
    var secondaryText = UIColor.rgb(145, 146, 148, 1)
    var interactiveText = UIColor.rgb(82, 158, 245, 1)
    var textfield = UIColor.rgb(242, 243, 245, 1)
}

struct Dark: Palettable {
    var foregroud = UIColor.rgb(25, 25, 27, 1)
    var backgroud = UIColor.rgb(0, 0, 0, 1)
    var cell = UIColor.rgb(25, 25, 27, 1)
    var text = UIColor.rgb(225, 226, 230, 1)
    var secondaryText = UIColor.rgb(143, 147, 153, 1)
    var interactiveText = UIColor.rgb(82, 158, 245, 1)
    var textfield = UIColor.rgb(35, 35, 37, 1)
}
