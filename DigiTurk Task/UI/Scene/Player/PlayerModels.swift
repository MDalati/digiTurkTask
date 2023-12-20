//
//  PlayerModels.swift
//  DigiTurk Task
//
//  Created by Mohammad Dalati on 20.12.2023.
//

import Foundation

enum PlayerModels {
    
    enum Initialize {
        
        struct Request { }
        
        struct Response {
            var videoURL: URL?
            var selectedProgram: ProgramResult
        }
        
        struct ViewModel {
            var videoURL: URL?
            var videoTitle: String?
        }
    }
}
