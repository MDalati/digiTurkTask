//
//  ProgramRequest.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import Foundation

struct ProgramRequest: Encodable {
    
    var apiKey: String = "3bb3e67969473d0cb4a48a0dd61af747"
    var sortBy: String = "popularity.desc"
    var includeAdult: Bool = false
    var includeVideo: Bool = false
    var page: Int
    var withGenres: Int
}
