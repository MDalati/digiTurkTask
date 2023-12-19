//
//  PlayerPresenter.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 20.12.2023.
//

import Foundation

protocol PlayerPresenterLogic {
    
    func presentInitializeResult(response: PlayerModels.Initialize.Response)
}

// MARK: - PlayerPresenter
class PlayerPresenter {
    
    var view: PlayerViewLogic
    init(view: PlayerViewLogic) {
        self.view = view
    }
}

// MARK: - PlayerPresenterLogic
extension PlayerPresenter: PlayerPresenterLogic {
    func presentInitializeResult(response: PlayerModels.Initialize.Response) {
        
        view.displayInitializeResult(viewModel: PlayerModels.Initialize.ViewModel())
    }
}
