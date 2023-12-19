//
//  MainConfigurator.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import Foundation

class MainConfigurator {
    
    static func config(mainVC: MainViewController) {
        
        let presenter = MainPresenter(view: mainVC)
        let worker = MainWorker()
        let interactor = MainInteractor(presenter: presenter, worker: worker)
        let router = MainRouter()
        mainVC.interactor = interactor
        mainVC.router = router
    }
}
