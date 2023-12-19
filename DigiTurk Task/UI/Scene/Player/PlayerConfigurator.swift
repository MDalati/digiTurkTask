//
//  PlayerConfigurator.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 20.12.2023.
//

import Foundation

class PlayerConfigurator {
    
    static func createScene() -> PlayerViewController {
        
        let playerVC = PlayerViewController()
        let presenter = PlayerPresenter(view: playerVC)
        let interactor = PlayerInteractor(presenter: presenter)
        let router = PlayerRouter()
        playerVC.interactor = interactor
        playerVC.router = router
        return playerVC
    }
}
