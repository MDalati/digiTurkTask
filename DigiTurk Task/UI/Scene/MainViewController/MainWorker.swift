//
//  MainWorker.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import Foundation

protocol MainWorkerLogic {
    
    func getGenres(completion: @escaping (GenreResponse?, Error?) -> Void)
}

class MainWorker: MainWorkerLogic {
    
    func getGenres(completion: @escaping (GenreResponse?, Error?) -> Void) {
        
        DigiTurkRequest.makeRequest(
            api: .genre(request: GenreRequest())
        ) { (response: GenreResponse?) in
            completion(response, nil)
        } onError: { error in
            completion(nil, error)
        }

    }
}
