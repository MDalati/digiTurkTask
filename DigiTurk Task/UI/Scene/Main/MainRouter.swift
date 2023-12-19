//
//  MainRouter.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import UIKit

protocol MainRouterLogic { }

class MainRouter: MainRouterLogic{
    
}

protocol MainRouterRoutable {
    
    func routeToMain(from sender: UIViewController)
}

extension MainRouterRoutable {
    
    func routeToMain(from sender: UIViewController) {
        
    }
}
