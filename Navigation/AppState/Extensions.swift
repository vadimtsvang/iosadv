//
//  Extensions.swift
//  Navigation
//
//  Created by Vadim on 08.09.2022.
//

import Foundation
import UIKit

public extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
          subviews.forEach { addSubview($0) }
      }
    
    func getButton (icon name: String, action: Selector ) -> UIButton {
        let button = UIButton()
        button.setCustomImage(name: name, size: 32)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    func getIcon (_ name: String, _ size: CGFloat = 32, _ color: UIColor) -> UIImage {
        UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(pointSize: size))?.withTintColor(color, renderingMode: .alwaysOriginal) ?? UIImage()
    }

}

public extension UIButton {
    
    func setCustomImage (name: String, size: CGFloat) {
        setImage((UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(pointSize: size))?.withTintColor(.black, renderingMode: .alwaysOriginal))!, for: .normal)
    }
}


public extension NSNotification.Name {
    static let codeRed = NSNotification.Name("codeRed")
    static let codeGreen = NSNotification.Name("codeGreen")
    static let residentsFetchingEnded = NSNotification.Name("residentsFetchingEnded")
    static let postDoubleTap = NSNotification.Name("postDoubleTap")
    static let showFeed = NSNotification.Name("showFeed")
    static let showMusic = NSNotification.Name("showMusic")

}

public extension UIViewController {
    
    var interfaceStyle: UIUserInterfaceStyle { traitCollection.userInterfaceStyle }
}

extension UIColor {
    static func createColor (lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return lightMode }
        
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}

extension UIColor {
    class func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: alpha)
    }
}

extension String {
    var localized: String { NSLocalizedString(self, comment: "") }
}
