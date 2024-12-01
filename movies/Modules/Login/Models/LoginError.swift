//
//  LoginError.swift
//  movies
//
//  Created by Yonny on 30/11/24.
//

import Foundation

enum LoginError: LocalizedError {
    
    case invalidUser
    case invalidPassword
    case error(message: String)
    
}

extension LoginError {
    
    var errorDescription: String? {
        switch self {
        case .invalidUser, .invalidPassword, .error:
            LoginConstants.errorTitle
        }
    }
    
    var failureReason: String? {
        switch self {
        case .invalidUser:
            LoginConstants.invalidUserErrorMessage
        case .invalidPassword:
            LoginConstants.invalidPasswordErrorMessage
        case .error(let message):
            message
        }
    }
    
}
