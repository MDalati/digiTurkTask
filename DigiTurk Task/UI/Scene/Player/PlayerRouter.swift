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
    
    func routeToPlayer(sender: UIViewController, for result: ProgramResult)
}

extension PlayerRoutable {
    
    func routeToPlayer(sender: UIViewController, for result: ProgramResult) {
        let playerVC = PlayerConfigurator.createScene(selectedProgram: result)
        sender.present(playerVC, animated: true)
    }
}
