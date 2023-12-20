//
//  UIView.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import UIKit

extension UIView {
    
    func roundCorners(with radius: CGFloat) {
        
        layer.cornerRadius = radius
    }
    
    func roundedView() {
        layer.cornerRadius = bounds.height/2
    }
}
