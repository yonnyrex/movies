//
//  ServiceError.swift
//  movies
//
//  Created by Yonny on 30/11/24.
//

import Foundation

struct ServiceError: LocalizedError, Decodable {
    
    let code: Int
    let message: String
    let success: Bool
    
    enum CodingKeys: String, CodingKey {
        case code = "status_code"
        case message = "status_message"
        case success
    }
    
    init(message: String = "Unknown", code: Int = 0, success: Bool = false) {
        self.message = message
        self.code = code
        self.success = success
    }
    
}
