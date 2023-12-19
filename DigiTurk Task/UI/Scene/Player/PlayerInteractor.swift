//
//  PlayerInteractor.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 20.12.2023.
//

import Foundation

protocol PlayerInteractorLogic {
    
    func initialize(request: PlayerModels.Initialize.Request)
}

protocol PlayerDatasource {
    
    var itemUrl: String { get }
}

class PlayerInteractor: PlayerDatasource {
    
    // MARK: Datasource
    let itemUrl: String = "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
    
    // MARK: VIP
    var presenter: PlayerPresenterLogic
    init(presenter: PlayerPresenterLogic) {
        self.presenter = presenter
    }
}


extension PlayerInteractor: PlayerInteractorLogic {
    
    func initialize(request: PlayerModels.Initialize.Request) {
        presenter.presentInitializeResult(response: PlayerModels.Initialize.Response())
    }
}
