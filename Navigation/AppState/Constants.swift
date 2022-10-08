//
//  Constants.swift
//  Navigation
//
//  Created by Vadim on 24.02.2022.
//

import UIKit

internal struct Constants {
    
    static let margin: CGFloat = 16
    static let offset: CGFloat = 20
    static let Inset: CGFloat = 8
    
    static let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
    
    static let navigationBarAppearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemGray5
        return appearance
    }()
    
//    static let interfaceStyle = UITraitCollection().userInterfaceStyle
}

// MARK: - Task 8: for asynchronous development and multithreading
internal extension Constants {
    
    static func timeToString(sec: Double) -> String {
        let minutes = Int(sec) / 60
        let seconds = sec - Double(minutes) * 60
        let secondsFraction = seconds - Double(Int(seconds))
        return String(format:"%02i:%02i.%02d",minutes,Int(seconds),Int(secondsFraction * 100.0))
    }

    
    static func showElapsedTimeAlert(navCon: UINavigationController, sec: Double)  {
        let alertController = UIAlertController(
            title: "alertLabel.done".localized,
            message: "\("alertmessage.elapsed".localized) \(timeToString(sec: sec))",
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "alertButton.ok".localized, style: .default))
        navCon.present(alertController, animated: true, completion: nil)
    }
}



