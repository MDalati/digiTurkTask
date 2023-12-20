//
//  UIImage.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func loadImage(from url: String?) {
        
        sd_imageTransition = .fade
        let placeholder = UIImage(named: "placeholder")
        guard let urlString = url else {
            return
        }
        sd_setImage(with: URL(string: urlString), placeholderImage: placeholder)
    }
}
