//
//  MainPresenter.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import Foundation

protocol MainPresenterLogic {
    
    func presentInitializeResult(response: MainModels.Initialize.Response)
    func presentReloadResult(response: MainModels.Reload.Response)
    func presentFinalizeResult(response: MainModels.Finilize.Response)
}

class MainPresenter {
    
    var view: MainViewLogic
    
    init(view: MainViewLogic) {
        self.view = view
    }
}

// MARK: - MainPresenterLogic

extension MainPresenter: MainPresenterLogic {
    
    func presentInitializeResult(response: MainModels.Initialize.Response) {
        
        let genrePages: [MainModels.GenrePageModel] = response.genresList.compactMap {
            return MainModels.GenrePageModel(
                viewController: GenreDetailsConfigurator.createScene(for: $0),
                title: $0.name
            )
        }
        view.displayInitializeResult(viewModel: MainModels.Initialize.ViewModel(pages: genrePages))
    }
    
    func presentReloadResult(response: MainModels.Reload.Response) {
        
    }
    
    func presentFinalizeResult(response: MainModels.Finilize.Response) {
        
    }
}
