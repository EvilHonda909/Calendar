//
//  BorderView.swift
//  Calendar
//
//  Created by macintosh on 10/02/2021.
//

import UIKit

class BottomBorder : CAShapeLayer {
    init(frame: CGRect, color: UIColor = .systemGray) {
        super.init()
        self.frame = frame
        
        self.path = {
            let linePath = UIBezierPath()
            linePath.move(to: CGPoint(x: self.frame.origin.x, y: self.frame.height))
            linePath.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
            return linePath.cgPath
        }()
        
        self.fillColor = nil
        self.opacity = 1.0
        self.strokeColor = color.cgColor
        
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
