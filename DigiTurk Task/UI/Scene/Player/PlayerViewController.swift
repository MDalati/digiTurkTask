//
//  PlayerViewController.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 20.12.2023.
//

import UIKit

protocol PlayerViewLogic {
    
    func displayInitializeResult(viewModel: PlayerModels.Initialize.ViewModel)
}

class PlayerViewController: UIViewController {

    // MARK: VIP
    var interactor: PlayerInteractorLogic?
    var router: PlayerRouterLogic?
    var datasource: PlayerDatasource? {
        return interactor as? PlayerDatasource
    }
    
    // MARK: Views
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

// MARK: - PlayerViewLogic
extension PlayerViewController: PlayerViewLogic {
    
    func displayInitializeResult(viewModel: PlayerModels.Initialize.ViewModel) { }
}
