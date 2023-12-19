//
//  PlayerRouter.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 20.12.2023.
//

import UIKit

protocol PlayerRouterLogic {
    
}

class PlayerRouter: PlayerRouterLogic {
    
}

protocol PlayerRoutable {
    
    func routeToPlayer(sender: UIViewController)
}

extension PlayerRoutable {
    
    func routeToPlayer(sender: UIViewController) {
        let playerVC = PlayerConfigurator.createScene()
        sender.present(playerVC, animated: true)
    }
}
