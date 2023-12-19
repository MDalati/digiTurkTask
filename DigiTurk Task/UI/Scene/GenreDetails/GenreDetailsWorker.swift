//
//  GenreDetailsWorker.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import Foundation

protocol GenreDetailsWorkerLogic {
    
    func getGenreItems(for genreId: Int, page: Int, completion: @escaping (ProgramsListResponse?, Error?) -> Void)
}

class GenreDetailsWorker: GenreDetailsWorkerLogic {
    
    func getGenreItems(
        for genreId: Int,
        page: Int,
        completion: @escaping (ProgramsListResponse?, Error?) -> Void
    ) {
        
        let programRequest = ProgramRequest(page: page, withGenres: genreId)
        DigiTurkRequest.makeRequest(
            api: .programs(request: programRequest)
        ) { (programsList: ProgramsListResponse?) in
            completion(programsList, nil)
        } onError: { error in
            completion(nil, error)
        }
    }
}
