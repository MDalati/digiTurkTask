//
//  GenreDetailsInteractor.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import Foundation

// MARK: - GenreDetailsInteractorLogic
protocol GenreDetailsInteractorLogic {
    
    func initialize(request: GenreDetailsModels.Initialize.Request)
    func reload(request: GenreDetailsModels.Reload.Request)
}

// MARK: - GenreDetailsDatasource
protocol GenreDetailsDatasource {
    
}

// MARK: - GenreDetailsInteractor
class GenreDetailsInteractor: GenreDetailsDatasource {
    
    // MARK: VIP
    var presenter: GenreDetailsPresnterLogic
    var worker: GenreDetailsWorkerLogic
    
    // MARK: Variables
    private var genre: GenreResult
    private var currentPage: Int = 1
    private var numberOfPages: Int = 1
    private var results: [ProgramResult] = []
    init(
        presenter: GenreDetailsPresnterLogic,
        worker: GenreDetailsWorkerLogic,
        genre: GenreResult
    ) {
        self.presenter = presenter
        self.worker = worker
        self.genre = genre
    }
    
}

// MARK: - GenreDetailsInteractorLogic
extension GenreDetailsInteractor: GenreDetailsInteractorLogic {
    
    func initialize(request: GenreDetailsModels.Initialize.Request) {
        worker.getGenreItems(for: genre.id ?? 0, page: currentPage) { [weak self] response, error in
            guard error == nil else {
                return
            }
            if let receivedPage = response?.page {
                self?.currentPage = receivedPage
            }
            self?.numberOfPages = response?.totalPages ?? 1
            self?.results = response?.results ?? []
            self?.presenter.presentInitialize(
                response: GenreDetailsModels.Initialize.Response(
                    programs: self?.results ?? []
                )
            )
        }
    }
    
    func reload(request: GenreDetailsModels.Reload.Request) {
        
        guard currentPage <= numberOfPages else {
            return
        }
        presenter.presentReload(
            response: GenreDetailsModels.Reload.Response(
                isLoading: true,
                programs: results
            )
        )
        
        worker.getGenreItems(for: genre.id ?? 0, page: currentPage + 1) { [weak self] response, error in
            guard error == nil else {
                return
            }
            if let receivedPage = response?.page {
                self?.currentPage = receivedPage
            }
            self?.results.append(contentsOf: response?.results ?? [])
            self?.presenter.presentReload(
                response: GenreDetailsModels.Reload.Response(
                    isLoading: false,
                    programs: self?.results ?? []
                )
            )
        }
    }
}

