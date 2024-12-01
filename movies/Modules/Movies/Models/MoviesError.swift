//
//  MoviesError.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

import Foundation

enum MoviesError: LocalizedError {
    
    case error(message: String)
    
}

extension MoviesError {
    
    var errorDescription: String? {
        switch self {
        case .error:
            "Movies"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .error(let message):
            message
        }
    }
    
}
