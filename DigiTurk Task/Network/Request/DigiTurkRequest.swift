//
//  DigiTurkRequest.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 19.12.2023.
//

import Foundation
import Alamofire

enum DigiTurkAPI {
    
    case genre(request: GenreRequest)
    case programs(request: ProgramRequest)
    
    var path: String {
        switch self {
        case .genre(_):
            return "genre/movie/list\(queryParams)"
        case .programs(_):
            return "discover/movie"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .genre, .programs:
            return .get
        }
    }
    
    var requestParams: [String: Encodable]? {
        
        switch self {
        case .genre(let request):
            return [
                "api_key": request.apiKey,
                "language": request.language
            ]
        case .programs(let request):
            return [
                "api_key": request.apiKey,
                "sort_by": request.sortBy,
                "include_adult": request.includeAdult,
                "include_video": request.includeVideo,
                "page": request.page,
                "withGenres": request.withGenres
            ]
        }
    }
    
    var queryParams: String {
        guard requestParams?.isEmpty == false else {
            return ""
        }
        let params = requestParams?.map { "\($0.key)=\($0.value)" }.joined(separator: "&") ?? ""
        return "?\(params)"
    }
}

class DigiTurkRequest {
    
    static private let baseUrl = "https://api.themoviedb.org/3/"
    
    static func makeRequest<T: Decodable> (api: DigiTurkAPI, onSuccess: @escaping (T?) -> Void, onError: @escaping (Error?) -> Void) {
        let requestURL = baseUrl + api.path
        AF.request(
            requestURL,
            method: api.method,
            encoding: JSONEncoding.default
        )
        .cURLDescription { description in
          print(description)
        }
        .response { response in
            DispatchQueue.main.async {
                guard response.error == nil, let data = response.data else {
                    onError(response.error)
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(T.self, from: data)
                    onSuccess(response)
                } catch {
                    onError(nil)
                }
            }
        }
    }
}
