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
            var programs: [ProgramResult]
        }
        
        struct ViewModel {
            var isLoading: Bool
            var presentations: [ProgramCellPresentation]
        }
    }
    
    enum Finilize {
        
        struct Request { }
        
        struct Response { }
        
        struct ViewModel { }
    }
}
