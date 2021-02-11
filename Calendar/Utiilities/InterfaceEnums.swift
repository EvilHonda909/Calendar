//
//  InterfaceEnums.swift
//  Calendar
//
//  Created by macintosh on 10/02/2021.
//

import UIKit

enum RoundedCornerStyle : CGFloat {
    case slightlyRounded = 8.0
    case highlyRounded = 4.0
    case rounded = 2.0
    
    func getMultiplier() -> CGFloat {
        return self.rawValue
    }
}

enum BorderWidthStyle : CGFloat {
    case thin = 64.0
    case bold = 32.0
    
    func getMultiplier() -> CGFloat {
        return self.rawValue
    }
}
