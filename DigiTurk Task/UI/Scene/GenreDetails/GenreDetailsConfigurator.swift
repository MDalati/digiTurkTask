//
//  GenreDetailsConfigurator.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import Foundation
import UIKit

class GenreDetailsConfigurator {
    
    static func createScene(for genreReuslt: GenreResult) -> GenreDetailsViewController {
        
        let viewController = GenreDetailsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let presenter = GenreDetailsPresnter(view: viewController)
        let worker = GenreDetailsWorker()
        let interactor = GenreDetailsInteractor(
            presenter: presenter,
            worker: worker,
            genre: genreReuslt
        )
        let router = GenreDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        return viewController
    }
}
