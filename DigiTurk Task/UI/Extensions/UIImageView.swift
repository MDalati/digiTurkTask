//
//  UIImage.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    
    func loadImage(from url: String?) {
        
        image = UIImage(named: "placeholder")
        guard let url = url else {
            return
        }
        AF.request(url, method: .get)
            .responseImage
        { response in
            if case .success(let image) = response.result {
                self.image = image
            }
        }
    }
}
