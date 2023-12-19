//
//  UIScrollView.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 20.12.2023.
//

import UIKit

extension UIScrollView {
    
    var reachedBottom: Bool {
        return contentOffset.y + frame.height >= contentSize.height
    }
}
