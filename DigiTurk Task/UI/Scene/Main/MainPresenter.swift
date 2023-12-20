//
//  MainPresenter.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import Foundation

// MARK: - MainPresenterLogic
protocol MainPresenterLogic {
    
    func presentInitializeResult(response: MainModels.Initialize.Response)
}

// MARK: - MainPresenter
class MainPresenter {
    
    var view: MainViewLogic
    
    init(view: MainViewLogic) {
        self.view = view
    }
}

// MARK: - MainPresenterLogic
extension MainPresenter: MainPresenterLogic {
    
    func presentInitializeResult(response: MainModels.Initialize.Response) {
        
        var genrePages: [MainModels.GenrePageModel] = []
        var capsuleListPresentations: [CapsuleCellPresentation] = []
        
        response.genresList.forEach {
            let capsulePresentation = CapsuleCellPresentation(
                title: $0.name,
                isSelected: false
            )
            capsuleListPresentations.append(capsulePresentation)
            let genrePage = MainModels.GenrePageModel(
                viewController: GenreDetailsConfigurator.createScene(for: $0),
                title: $0.name
            )
            genrePages.append(genrePage)
        }
        view.displayInitializeResult(
            viewModel: MainModels.Initialize.ViewModel(
                pages: genrePages,
                capsuleListPresentations: capsuleListPresentations
            )
        )
    }
}
