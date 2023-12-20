//
//  GenreDetailsPresenter.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import Foundation

// MARK: - GenreDetailsPresnterLogic
protocol GenreDetailsPresnterLogic {
    
    func presentInitialize(response: GenreDetailsModels.Initialize.Response)
    func presentReload(response: GenreDetailsModels.Reload.Response)
    func presentOpenProgram(response: GenreDetailsModels.OpenProgram.Response)
}

// MARK: - GenreDetailsPresnter
class GenreDetailsPresnter {
    
    var view: GenreDetailsViewLogic
    
    init(view: GenreDetailsViewLogic) {
        self.view = view
    }
}

// MARK: - GenreDetailsPresnterLogic
extension GenreDetailsPresnter: GenreDetailsPresnterLogic {

    func presentInitialize(response: GenreDetailsModels.Initialize.Response) {
        
        let presentations = response.programs.map {
            ProgramCellPresentation(
                id: $0.id,
                title: $0.title,
                imageUrl: $0.coverImageURL
            )
        }
        view.displayInitializeResult(
            viewModel: GenreDetailsModels.Initialize.ViewModel(
                presentations: presentations
            )
        )
    }
    
    func presentReload(response: GenreDetailsModels.Reload.Response) {
        
        let presentations = response.newPagePrograms.map {
            ProgramCellPresentation(
                id: $0.id,
                title: $0.title,
                imageUrl: $0.coverImageURL
            )
        }
        var insertionIndexPathes: [IndexPath] = []
        if response.insertionStartIndex > -1 {
            for index in response.insertionStartIndex ..< response.allElementsCount {
                insertionIndexPathes.append(IndexPath(row: index, section: 0))
            }
        }
        view.displayReloadResult(
            viewModel: GenreDetailsModels.Reload.ViewModel(
                isLoading: response.isLoading,
                newPagePresentations: presentations,
                insertionIndexPathes: insertionIndexPathes
            )
        )
    }
    
    func presentOpenProgram(response: GenreDetailsModels.OpenProgram.Response) {
        view.displayOpenProgramResult(
            viewModel: GenreDetailsModels.OpenProgram.ViewModel(
                selectedProgram: response.selectedProgram
            )
        )
    }
}
