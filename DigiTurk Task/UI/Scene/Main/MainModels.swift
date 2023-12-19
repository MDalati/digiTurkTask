//
//  MainModels.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import Foundation

enum MainModels {
    
    struct GenrePageModel {
        var viewController: GenreDetailsViewController
        var title: String?
    }
    
    enum Initialize {
        
        struct Request { }
        
        struct Response {
            
            var genresList: [GenreResult]
        }
        
        struct ViewModel {
            
            var pages: [GenrePageModel]
        }
    }
    
    enum Reload {
        
        struct Request { }
        
        struct Response { }
        
        struct ViewModel { }
    }
    
    enum Finilize {
        
        struct Request { }
        
        struct Response { }
        
        struct ViewModel { }
    }
}
