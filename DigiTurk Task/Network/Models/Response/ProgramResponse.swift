//
//  ProgramResponse.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import Foundation

struct ProgramResponse: Decodable {
    
    var page: Int?
    var results: [ProgramResult]?
    var totalPages: Int?
    var totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
