//
//  MainInteractor.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import Foundation

// MARK: - MainInteractorLogic
protocol MainInteractorLogic {
    
    func initialize(request: MainModels.Initialize.Request)
}

// MARK: - MainDatasource
protocol MainDatasource {
    
}

// MARK: - MainInteractor
class MainInteractor: MainDatasource {
    
    // MARK: VIP
    
    var presenter: MainPresenterLogic
    var worker: MainWorkerLogic
    
    // MARK: Variables
    
    private var genresList: [GenreResult] = []
    
    init(presenter: MainPresenterLogic, worker: MainWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}

// MARK: - MainInteractorLogic
extension MainInteractor: MainInteractorLogic {
    
    func initialize(request: MainModels.Initialize.Request) {
        
        worker.getGenres { [weak self] response, error in
            
            let genres = response?.genres ?? []
            self?.genresList = genres
            self?.presenter.presentInitializeResult(
                response: MainModels.Initialize.Response(genresList: genres)
            )
        }
    }
}
