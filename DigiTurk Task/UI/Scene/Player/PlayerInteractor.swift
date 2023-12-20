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

protocol PlayerDatasource { }

class PlayerInteractor: PlayerDatasource {
    
    // MARK: VIP
    var presenter: PlayerPresenterLogic
    
    // MARK: Variables
    private var currentProgram: ProgramResult
    private let videoURL = URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")
    
    init(presenter: PlayerPresenterLogic, selectedProgram: ProgramResult) {
        self.presenter = presenter
        self.currentProgram = selectedProgram
    }
}


extension PlayerInteractor: PlayerInteractorLogic {
    
    func initialize(request: PlayerModels.Initialize.Request) {
        presenter.presentInitializeResult(
            response: PlayerModels.Initialize.Response(
                videoURL: videoURL,
                selectedProgram: currentProgram
            )
        )
    }
}
