//
//  LoginService.swift
//  movies
//
//  Created by Yonny on 30/11/24.
//

import Foundation
import Combine

protocol LoginServiceType {
    
    func login(user: String, password: String) -> AnyPublisher<LoginResponse, ServiceError>
    
}

struct LoginService: LoginServiceType {
    
    func login(user: String, password: String) -> AnyPublisher<LoginResponse, ServiceError> {
        return Future<LoginResponse, ServiceError> { promise in
            if user == "Admin" && password == "Password*123" {
                let response = LoginResponse(success: true, message: "Bienvenido")
                promise(.success(response))
            } else {
                let error = ServiceError(message: "Credenciales invalidos", code: 401, success: false)
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
}

