//
//  CustomIcon.swift
//  Navigation
//
//  Created by Vadim on 13.09.2022.
//

import Foundation
import UIKit

final class CustomIcon: UIImageView {
    
    let name: String
    let size: CGFloat
    var color: UIColor
    
    var tapAction: (() -> Void)?
    
    init (
        name: String,
        size: CGFloat = 32,
        color: UIColor = .black
    ) {
        self.name = name
        self.size = size
        self.color = color
        super.init(frame: .zero)
        
        image = UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(pointSize: size))?.withTintColor(color, renderingMode: .alwaysOriginal) ?? UIImage()
        contentMode = .scaleAspectFit
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.gesture))
        recognizer.numberOfTapsRequired = 1
        addGestureRecognizer(recognizer)
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func gesture() {
        tapAction?()
    }
}

