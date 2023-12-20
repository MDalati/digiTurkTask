//
//  GenreDetailsModels.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import Foundation

enum GenreDetailsModels {
    
    enum Initialize {
        
        struct Request { }
        
        struct Response {
            var programs: [ProgramResult]
        }
        
        struct ViewModel {
            var presentations: [ProgramCellPresentation]
        }
    }
    
    enum Reload {
        
        struct Request { }
        
        struct Response {
            var isLoading: Bool
            var newPagePrograms: [ProgramResult]
            var insertionStartIndex: Int
            var allElementsCount: Int
        }
        
        struct ViewModel {
            var isLoading: Bool
            var newPagePresentations: [ProgramCellPresentation]
            var insertionIndexPathes: [IndexPath]
        }
    }
    
    enum OpenProgram {
        
        struct Request {
            var index: Int
        }
        
        struct Response {
            var selectedProgram: ProgramResult
        }
        
        struct ViewModel {
            var selectedProgram: ProgramResult
        }
    }
}
