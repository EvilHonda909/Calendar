//
//  InterfaceConfigurators.swift
//  Calendar
//
//  Created by macintosh on 10/02/2021.
//

import UIKit


extension UIView {
    func setRoundedCorners(style: RoundedCornerStyle) {
        let cornerRadius = self.bounds.height / style.getMultiplier()
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func setBorderWidthAndColor(color: UIColor, width: BorderWidthStyle ) {
        let borderWidth = self.bounds.height / width.getMultiplier()
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
    
}

extension UITextField {
    func setTextFieldColorAndHideBorder() {
        self.borderStyle = .none
        self.backgroundColor = .calendarBackground
    }
}

