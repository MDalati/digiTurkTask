//
//  ViewController.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import UIKit

protocol MainViewLogic {
    
    func displayInitializeResult(viewModel: MainModels.Initialize.ViewModel)
    func displayReloadResult(viewModel: MainModels.Reload.ViewModel)
    func displayFinalizeResult(viewModel: MainModels.Finilize.ViewModel)
}

class MainViewController: UIViewController {

    // MARK: VIP
    var interactor: MainInteractorLogic?
    var router: MainRouterLogic?
    
    var datasource: MainDatasource? {
        return interactor as? MainDatasource
    }
    
    // MARK: Variables
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MainConfigurator.config(mainVC: self)
        interactor?.initialize(request: MainModels.Initialize.Request())
    }
}

// MARK: - MainViewLogic

extension MainViewController: MainViewLogic {
    
    func displayInitializeResult(viewModel: MainModels.Initialize.ViewModel) {
        
    }
    
    func displayReloadResult(viewModel: MainModels.Reload.ViewModel) {
        
    }
    
    func displayFinalizeResult(viewModel: MainModels.Finilize.ViewModel) {
        
    }
}
