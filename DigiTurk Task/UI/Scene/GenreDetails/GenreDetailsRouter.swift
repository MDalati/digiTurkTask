//
//  GenreDetailsRouter.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import UIKit

protocol GenreDetailsRouterLogic: PlayerRoutable {
    
}

class GenreDetailsRouter: GenreDetailsRouterLogic {
    
}

protocol GenreDetailsRoutable {
    
    func routeToGenreDetails(for genreResult: GenreResult, sender: UIViewController)
}

extension GenreDetailsRoutable {
    
    func routeToGenreDetails(for genreResult: GenreResult, sender: UIViewController) {
        
        let genreDetailsVc = GenreDetailsConfigurator.createScene(for: genreResult)
        sender.present(genreDetailsVc, animated: true)
    }
}
