//
//  UIImage.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import UIKit
import Alamofire

extension UIImageView {
    
    func loadImage(from url: String?) {
        
        image = UIImage(named: "placeholder")
        guard let url = url else {
            return
        }
        AF.request(url, method: .get)
            .response
        { response in
            guard let imageData = response.data else {
                return
            }
            self.image = UIImage(data: imageData, scale:1)
        }
    }
}
