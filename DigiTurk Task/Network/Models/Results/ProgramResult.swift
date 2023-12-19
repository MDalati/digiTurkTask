//
//  ProgramResult.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import Foundation

struct ProgramResult: Decodable {
    
    private let imageBaseUrl = "http://image.tmdb.org/t/p/w185"
    
    var adult: Bool?
    var backdropPath: String?
    var genreIds: [Int]?
    var id: Int?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var video: Bool
    var voteAverage: Double?
    var voteCount: Int?
    
    var coverImageURL: String? {
        guard let posterPath = posterPath else {
            return nil
        }
        return "\(imageBaseUrl)\(posterPath)"
    }
    
    enum CodingKeys: String, CodingKey {
        
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
